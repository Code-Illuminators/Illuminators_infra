pipeline {
    agent any

    parameters {
            choice(
                name: 'ENV',
                choices: ['stage-01', 'prod-01','dev-01'],
                description: 'Select the environment'
            )
            choice(
                name: 'ACTION',
                choices: ['plan', 'apply', 'destroy'],
                description: 'Select the terraform action'
            )
            choice(
                name: 'SETUP',
                choices: ['account-setup', 'birdwatching-setup', 'environment-setup', 'illuminati-setup', 'portal-setup'],
                description: 'Select the terraform module to deploy'
            )
        }

    stages {
        stage('Clone Repository') {
            steps {
                checkout scm
            }
        }

        stage('Deployment') {
            steps {
                    script {
                        def account_id_map = [
                            'dev-01': '235194330448',
                            'stage-01': '037490753541',
                            'prod-01': '321'
                        ]

                        def account_id = account_id_map[params.ENV]

                        def jenkins_account_id = '037490753541'

                        dir("${params.SETUP}") {
                            if (account_id != jenkins_account_id) {
                            withAWS(roleAccount: account_id, role: "terraform-deployment-role-${params.ENV}") {
                                sh "make ${params.ACTION} BIRD_ENV=${params.ENV}"
                            }
                            } else {
                                sh "make ${params.ACTION} BIRD_ENV=${params.ENV}"
                            }
                            }
                        }

                    }
                }
            }
        }