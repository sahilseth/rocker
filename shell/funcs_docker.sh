containerid="rocker_binder_seths3_8080"
tag=202308
# just replacing the tag

rocker()
{
    docker exec -it ${containerid} bash
}


rocker_commit()
{   
    docker commit ${containerid} sahilseth/rocker_binder:4.3.1_202308
    
    # remove dangling images
    echo "removing dangling images"
    # https://stackoverflow.com/questions/40112543/remove-existing-image-when-using-docker-commit
    docker rmi $(docker images -f "dangling=true" -q)
}

rocker_push()
{  
    aws_ecr_login
    echo "pushing image to ECR"
    docker push sahilseth/rocker_binder:4.3.1_202308
}


omics431(){
    mamba activate omics431
}

