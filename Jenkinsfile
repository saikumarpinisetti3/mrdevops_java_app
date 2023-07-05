@LIbrary('my-shared-library') _
pipeline{

    agent any
    stages{
        stage('git checkout'){
        steps{
            script{
                gitCheckout(
                    branch: "main",
                    url: "https://github.com/saikumarpinisetti3/mrdevops_java_app.git"
                )

             }
         }
     }
    }
}
