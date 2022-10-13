#!/usr/bin/env groovy

pipeline {
    agent any

    tools {
      terraform 'terraform'
    }

    environment {
      TF_IN_AUTOMATION = 'true'
      AWS_SHARED_CREDENTIALS_FILE='/root/.aws/credentials'
    }

    stages {
      stage('Init TF') {
        steps {
          script {
              dir('terraform') {
                sh '''
                  ls -al
                  cat main.tf
                  terraform init
                '''
              }
          }
        }
      }

      stage('Plan TF') {
        steps {
          script {
              dir('terraform') {
                sh '''
                  terraform plan
                '''
              }
          }
        }
      }

      stage('Validate TF') {
        input {
          message "Do you want to apply this Plan?"
          ok "Apply Plan"
        }
        steps {
          echo 'Plan Accepted'
        }
      }

      stage('Apply TF') {
        steps {
          script {
              dir('terraform') {
                sh '''
                  terraform apply -auto-approve
                '''
              }
          }
        }
      }

      stage('Print Inventory') {
        steps {
          script {
           dir('terraform') {
              sh '''
                echo $(terraform output -json ec2_public_ip) | awk -F'"' '{print $2}' > aws_hosts
                cat aws_hosts
              '''
            }
          }
        }
      }

      stage('Wait EC2') {
        steps {
          script {
           dir('terraform') {
            sh '''
              aws ec2 wait instance-status-ok --region us-west-1 --instance-ids `$(terraform output -json ec2_id) | awk -F'"' '{print $2}'`
            '''
            }
          }
        }
      }

      stage('Validate Ansible') {
        input {
          message "Do you want to run Ansible Playbook?"
          ok "Run Ansible"
        }
        steps {
          echo "Ansible Accepted"
        }
      }

      stage('Run Ansible') {
        steps {
          ansiblePlaybook(credentialsId: 'ec2.ssh.key	', inventory: 'aws_hosts', playbook: 'ansible/deploy-docker-newuser.yaml')
        }
      }

      stage('Validate Destroy') {
        input {
          message "Do you want to destroy Terraform Infra?"
          ok "Destroy"
        }
        steps {
          echo "Destroy Accepted"
        }
      }

      stage('Destroy TF') {
        steps {
          script {
              dir('terraform') {
                sh '''
                  terraform destroy -auto-approve
                '''
              }
          }
        }
      }

  }
}
