# PHP-Mesher-Example
   

 1) Start the service center (download the service center from http://servicecomb.incubator.apache.org/release/)
 
     
     
 2) update the servicecenter ip address in docker-compose.yml
 3) using dockercompose build the container image of php server and php client and start the the container along with mesher
  
     docker-compose up
 4) To verify the php client and php server communication
 
       curl request http://[ipaddress of the client]:80/client.php
      
