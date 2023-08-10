node{
    

    stage('git checkout'){
        git 'https://github.com/romanazaidi/Terransible'
        
    }
    
    
    stage('Initialize Terraform'){
        
        
        
        sh 'terraform init'
        
    }
    
     stage('Plan Terraform'){
         
         
    
        sh 'terraform plan'
        
         
     }
        
    
    
   stage('Apply the changes'){
        
        sh 'terraform apply --auto-approve'
        
    }
    
    stage('configuring newly created machine with ansible'){
    
    ansiblePlaybook become: true, credentialsId: 'ansible-keys', disableHostKeyChecking: true, installation: 'ansible', inventory: '/etc/ansible/hosts', playbook: 'ansible-playbook.yml'
    }
    
    
    
    /*
    stage('destroy terraform'){
    
    sh 'terraform destroy --auto-approve'
}*/
    
}
