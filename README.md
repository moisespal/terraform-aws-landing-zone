# AWS Landing Zone with Terraform

This project is my attempt at building an AWS Landing Zone from scratch using Terraform, without the assistance of AWS Control Tower.

I wanted to understand how multi-account architecture, security, governance, and networking work together in AWS, rather than just following tutorials and using the AWS Management Console.

## What I Built

- **AWS Organizations:** Created Security, Infrastructure, and Workloads OUs, including nested Dev and Prod OUs.
- **SCPs:** Added security guardrails to restrict certain actions and AWS Regions.
- **IAM Identity Center:** Configured users, groups, and permission sets to manage access across accounts.
- **Centralized Logging:** Created a Log Archive account to store CloudTrail logs from across the organization in S3.
- **Networking:** Created a VPC with 3 public and 3 private subnets across 3 Availability Zones, including an Internet Gateway and route tables.

## Documentation

I documented the steps I took, screenshots, Terraform code, and the reasoning behind my decisions.

[My Landing Zone Documentation](https://docs.google.com/document/d/e/2PACX-1vQVlZyTKHvUxJs9oof4NSbZ6mR29xK_O-XdrDogSucL-Nu93c0adjhvbSksJpYbRN0TfH9_sPhIbpJU/pub)

## Final Thoughts

Building this from scratch was more difficult than I expected. There were mistakes and things I wish I had done differently, but I learned a lot more from working through them than I did from watching concept videos.

I plan to improve my landing zone as time goes on and build upon my documentation as I gain more experience and start introducing real workloads.
