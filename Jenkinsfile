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
    
    ansiblePlaybook become: true, credentialsId: 'ansibleKey', disableHostKeyChecking: true, installation: 'ansible', inventory: '/etc/ansible/host', playbook: 'ansible-playbook.yml'
    }
    
    
    
    /*
    stage('destroy terraform'){
    
    sh 'terraform destroy --auto-approve'
}*/
    
}
