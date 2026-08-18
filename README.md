\# Serverless Cloud Resume Platform



A production-style serverless resume website built on AWS and managed using Terraform.



The project hosts a personal resume website through Amazon S3 and CloudFront, uses Route 53 and ACM for DNS and HTTPS, and implements a serverless visitor counter using API Gateway, AWS Lambda, and DynamoDB.



\---



\## Architecture



```text

&#x20;                        ┌──────────────────┐

&#x20;                        │      User        │

&#x20;                        │    Browser       │

&#x20;                        └────────┬─────────┘

&#x20;                                 │

&#x20;                          HTTPS Request

&#x20;                                 │

&#x20;                                 ▼

&#x20;                        ┌──────────────────┐

&#x20;                        │    Route 53      │

&#x20;                        │      DNS         │

&#x20;                        └────────┬─────────┘

&#x20;                                 │

&#x20;                                 ▼

&#x20;                        ┌──────────────────┐

&#x20;                        │   CloudFront     │

&#x20;                        │   CDN + HTTPS    │

&#x20;                        └────────┬─────────┘

&#x20;                                 │

&#x20;                          OAC / SigV4

&#x20;                                 │

&#x20;                                 ▼

&#x20;                        ┌──────────────────┐

&#x20;                        │    Amazon S3     │

&#x20;                        │ Static Website   │

&#x20;                        └──────────────────┘





&#x20;                   Visitor Counter Flow



&#x20;                        ┌──────────────────┐

&#x20;                        │ Website JavaScript│

&#x20;                        └────────┬─────────┘

&#x20;                                 │

&#x20;                            POST /visitors

&#x20;                                 │

&#x20;                                 ▼

&#x20;                        ┌──────────────────┐

&#x20;                        │   API Gateway    │

&#x20;                        │    HTTP API      │

&#x20;                        └────────┬─────────┘

&#x20;                                 │

&#x20;                                 ▼

&#x20;                        ┌──────────────────┐

&#x20;                        │   AWS Lambda     │

&#x20;                        │ Visitor Counter  │

&#x20;                        └────────┬─────────┘

&#x20;                                 │

&#x20;                                 ▼

&#x20;                        ┌──────────────────┐

&#x20;                        │   DynamoDB       │

&#x20;                        │ Visitor Counter  │

&#x20;                        └──────────────────┘



AWS Services Used

Service	Purpose

Amazon S3	Hosts static website files

Amazon CloudFront	CDN, HTTPS delivery and caching

AWS Certificate Manager	SSL/TLS certificate

Amazon Route 53	DNS management

Amazon API Gateway	HTTP API endpoint

AWS Lambda	Serverless visitor counter logic

Amazon DynamoDB	Stores visitor count

AWS IAM	Lambda execution permissions

CloudFront OAC	Secure S3 origin access

Terraform	Infrastructure as Code

Project Features

Static resume website hosted on Amazon S3

Global content delivery using CloudFront

HTTPS using AWS Certificate Manager

Custom domain using Route 53

CloudFront Origin Access Control for S3

Serverless visitor counter

API Gateway HTTP API

AWS Lambda backend

DynamoDB visitor counter storage

IAM role and policy for Lambda

Infrastructure managed using Terraform

Existing AWS resources imported into Terraform state

Infrastructure drift verification using terraform plan

Git version control and checkpoints

Visitor Counter



The website contains a visitor counter implemented using a completely serverless architecture.



The request flow is:



Browser

&#x20;  │

&#x20;  │ POST /visitors

&#x20;  ▼

API Gateway

&#x20;  │

&#x20;  ▼

Lambda

&#x20;  │

&#x20;  │ Read / Update

&#x20;  ▼

DynamoDB

&#x20;  │

&#x20;  ▼

Visitor Count

&#x20;  │

&#x20;  ▼

Lambda → API Gateway → Browser



The DynamoDB table is:



cloud-resume-visitor-counter



The table uses:



Partition Key: id

Type: String

Billing Mode: PAY\_PER\_REQUEST

Website Delivery Architecture



The resume website is stored in Amazon S3 and delivered through CloudFront.



User

&#x20; │

&#x20; ▼

Route 53

&#x20; │

&#x20; ▼

CloudFront

&#x20; │

&#x20; │ Signed request using OAC

&#x20; ▼

S3



CloudFront provides:



HTTPS

CDN caching

Global content delivery

Custom domain support

Secure S3 origin access



The S3 bucket is not intended to be directly accessed by the public.



CloudFront uses Origin Access Control (OAC) with SigV4 signing to access the S3 origin.



Security



Security was implemented at multiple layers.



CloudFront → S3



CloudFront uses an Origin Access Control:



Signing Protocol: SigV4

Signing Behavior: Always

Origin Type: S3



This allows CloudFront to securely access the S3 bucket.



S3 Bucket Policy



The bucket policy permits CloudFront's service principal to retrieve objects for the configured distribution.



The CloudFront distribution ARN is used as a condition to restrict access.



Direct S3 Access Testing



Direct access to the S3 HTTPS endpoint was tested and returned:



HTTP/1.1 403 Forbidden



This confirms that the intended CloudFront-based access path is enforced.



HTTPS



AWS Certificate Manager provides the SSL/TLS certificate for:



shashanktj.com

www.shashanktj.com



The certificate is issued in:



us-east-1



because CloudFront certificates must be provisioned in the US East (N. Virginia) region.



Certificate validation is performed through DNS records managed by Route 53.



The certificate status was verified as:



ISSUED



Both domain validation records returned:



ValidationStatus: SUCCESS

Route 53



Route 53 manages DNS for:



shashanktj.com



The root A record is configured as an alias pointing to the CloudFront distribution.



shashanktj.com

&#x20;      │

&#x20;      ▼

Route 53

&#x20;      │

&#x20;      ▼

CloudFront



The hosted zone is a public hosted zone.



API Gateway



The project uses Amazon API Gateway HTTP API.



API:



Cloud Resume API



Route:



POST /visitors



The route is connected to the Lambda function through an AWS\_PROXY integration.



API Gateway provides the public HTTP interface between the website and the serverless backend.



AWS Lambda



Lambda executes the visitor counter backend logic.



Function:



cloud-resume-visitor-counter



The Lambda function communicates with DynamoDB to retrieve and update the visitor count.



The Lambda execution role provides the permissions required for DynamoDB operations.



DynamoDB



The visitor counter is stored in:



cloud-resume-visitor-counter



Configuration:



Region: ap-south-2

Billing Mode: PAY\_PER\_REQUEST

Table Class: STANDARD

Partition Key: id

Partition Key Type: String



DynamoDB provides a serverless and scalable datastore without requiring database server management.



Infrastructure as Code



The AWS infrastructure is managed using Terraform.



Terraform resources include:



API Gateway

CloudFront

CloudFront OAC

DynamoDB

IAM Role

IAM Policy

Lambda

Route 53 Hosted Zone

Route 53 Record

S3 Bucket

S3 Bucket Policy

S3 Ownership Controls

S3 Public Access Block



Terraform was also used to import existing AWS resources into Terraform state instead of recreating them.



Examples of resources imported and reconciled include:



Route 53 Hosted Zone

Route 53 A Record

API Gateway Route

API Gateway Integration

API Gateway Stage

CloudFront Distribution

CloudFront OAC

S3 Security Configuration

Terraform Workflow



The infrastructure was managed using the following workflow:



1\. Inspect existing AWS resources

&#x20;         ↓

2\. Create Terraform configuration

&#x20;         ↓

3\. terraform fmt

&#x20;         ↓

4\. terraform validate

&#x20;         ↓

5\. terraform import

&#x20;         ↓

6\. terraform plan

&#x20;         ↓

7\. Reconcile differences

&#x20;         ↓

8\. terraform apply when required

&#x20;         ↓

9\. terraform plan

&#x20;         ↓

10\. No changes

&#x20;         ↓

11\. Git checkpoint



The final verification produced:



No changes.

Your infrastructure matches the configuration.



This confirms that Terraform configuration and the deployed AWS infrastructure are synchronized.



Terraform Project Structure

terraform/

│

├── .gitignore

├── .terraform.lock.hcl

│

├── main.tf

├── provider.tf

├── variables.tf

├── outputs.tf

│

├── cloudfront.tf

├── route53.tf

├── route53-records.tf

├── s3-security.tf

│

└── README.md



Terraform state files and the .terraform directory are excluded from Git using .gitignore.



Terraform State



Terraform state is maintained locally for this project.



The following files are intentionally excluded from Git:



.terraform/

\*.tfstate

\*.tfstate.\*

\*.tfplan

\*.tfvars

\*.tfvars.json



This prevents Terraform state and potentially sensitive variable files from being committed to the repository.



Validation



The infrastructure was validated using:



terraform fmt

terraform validate

terraform plan



Final Terraform verification:



No changes.

Your infrastructure matches the configuration.



AWS resources were also verified using AWS CLI commands.



Application Verification



The deployed application was tested successfully.



Website

https://shashanktj.com



Result:



Working

Visitor Counter

Working

Visitor Count Updates

Working

Direct S3 Access

HTTP/1.1 403 Forbidden



This confirms that the website is being served through the intended CloudFront path rather than relying on unrestricted direct S3 access.



AWS CLI Verification



Several AWS CLI commands were used to verify the deployed infrastructure.



Examples:



aws s3api head-bucket --bucket shashanktj.com

aws dynamodb describe-table \\

&#x20; --table-name cloud-resume-visitor-counter \\

&#x20; --region ap-south-2

aws cloudfront get-distribution \\

&#x20; --id <DISTRIBUTION\_ID>

aws route53 list-resource-record-sets \\

&#x20; --hosted-zone-id <HOSTED\_ZONE\_ID>

aws acm describe-certificate \\

&#x20; --region us-east-1 \\

&#x20; --certificate-arn <CERTIFICATE\_ARN>



These commands were used to verify resource configuration and deployment state.



Git Version Control



The project uses Git for version control.



Development checkpoints were created throughout the Terraform implementation.



Examples:



Day 16: Terraform API Gateway complete

Day 17: Terraform CloudFront complete

Day 18: Secure S3 with CloudFront OAC

Day 18: Terraform Route 53 complete



The final repository was verified with:



git status



Result:



nothing to commit, working tree clean

Key Concepts Learned



Through this project, the following concepts were implemented and practiced:



Infrastructure as Code

Terraform resource management

Terraform state

Terraform import

Infrastructure drift detection

AWS serverless architecture

Static website hosting

CDN architecture

DNS management

HTTPS and TLS certificates

CloudFront Origin Access Control

IAM roles and policies

API Gateway integrations

Lambda execution

DynamoDB

AWS CLI

Git version control

Cloud security

Least-privilege access concepts

Project Outcome



The final application demonstrates a complete serverless AWS architecture.



Website delivery:



Route 53

&#x20;   ↓

CloudFront + ACM

&#x20;   ↓

S3



Visitor counter:



Website

&#x20;   ↓

API Gateway

&#x20;   ↓

Lambda

&#x20;   ↓

DynamoDB



Terraform manages the AWS infrastructure as code, allowing the deployed environment to be inspected, modified, imported, and validated through configuration.



The project demonstrates practical experience with AWS cloud infrastructure, serverless services, Infrastructure as Code, security, DNS, HTTPS, Git, and AWS CLI.



Author



Shashank TJ



Cloud Computing | AWS | Terraform | Linux | DevOps



Website: https://shashanktj.com



GitHub: Add your GitHub profile



LinkedIn: Add your LinkedIn profile

