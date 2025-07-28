Automation to export Bitwarden credentials and store them safely using AWS s3.

To use this project set credentials on AWS secrets manager.

name the credentials as:
BW_CLIENTID 
BW_CLIENTSECRET
BW_PASSWORD
email
password

get BW_CLIENTID and BW_CLIENTSECRET from 
![alt text]([https://bitwarden.com/help/public-api/](https://bitwarden.com/assets/1Mq824Xunm2wmzd8f905AJ/792cca9c6edddee71abfc350479ec813/Screenshot_2024-02-28_at_2.43.34_PM.png?w=1200&fm=avif&q=80))

BW_PASSWORD -> Bitwarden master key( needed to export credentials through bitwarden cli)
email -> subscribe an email to nofity you about successful backup(optional)
password -> application password provided from the email service provider(optional)

P.S change the s3 bucket name to someting appropriate as the name provided in s3.tf is taken.
