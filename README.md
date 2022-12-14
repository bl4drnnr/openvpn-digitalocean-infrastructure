<h1 align="center">
    OpenVPN DigitalOcean Infrastructure
</h1>

## Table of contents
1. [Introduction](#introduction)
2. [Prerequirements](#prerequirements)
2. [Theory](#theory)
3. [Network Diagram and Description](#network-diagram-and-description)
4. [Step-by-Step Guideline](#step-by-step-guideline)
5. [Repository Source Code Usage](#repository-source-code-usage)
6. [References and Contact](#references-and-contact)
7. [License](#license)

![DigitalOcean](https://img.shields.io/badge/DigitalOcean-%230167ff.svg?style=for-the-badge&logo=digitalOcean&logoColor=white)
![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)

---

### Introduction

**OpenVPN** - is a virtual private network system that implements techniques to create secure point-to-point or site-to-site connections in routed or bridged configurations and remote access facilities. It implements both client and server applications.

**DigitalOcean** - is an American cloud infrastructure provider. DigitalOcean provides developers, startups, and SMBs with cloud **infrastructure-as-a-service** (or just **IaaS**) platforms.

**Terraform** - is an open-source, infrastructure as code, software tool created by HashiCorp. Users define and provide data center infrastructure using a declarative configuration language known as HashiCorp Configuration Language, or optionally JSON.

The presented project presents **OpenVPN** infrastructure build on **DigitalOcean** with help of **Terraform** IaaS programming language. Bellow will be described:

- the diagram of the whole built virtual privagte network with devices
- step-by-step instruction on how to implement it using **Terraform** (this repository) and on your own
- detailed information about **TLS/SSL, HTTPS, certificates, key pairs** etc.

_**Happy reading!**_

---

### Prerequirements

In order to execute and build current infrastructure, make sure you have `Terraform` and `Ansible` installed on your machine.

Versions can be checked by typing in terminal:

1. `terraform --version`

    ```
    Terraform v1.3.4
    ```

2. `ansible --version`

    ```
    ansible [core 2.13.6]
    ```

Also, you'll have to obtain your `DigitalOcean` API token. More about how to generate and how to use this token you can find [here](#references-and-contact).

---

### Theory

Let's start with a little bit of theory.

First of all, we shoud define terminology we are going to use.

1. **Client** - end-user, you or your laptop, mobile phone etc.
2. **OpenVPN Server** (or just **server**) - server, where we configured our OpenVPN service. Also, this is server we, as clients, are going to connect.
3. **Certificate Authorities** (or just **CA**) - is an entity that stores, signs, and issues digital certificates. In our particular case, it is only going to sign requests by server.
4. **Certificate** - in cryptography, a public key certificate, also known as a digital certificate or identity certificate, is an electronic document used to prove the validity of a public key. Certificate contains public key of the owner and signing by CA.

One very important thing that should be mentioned:
- Only our **OpenVPN Server** will be the only one entity, that will generate private keys and certificates for **clients**. Even though our server generates **private key**, it never should keep it. The only one entity, that can have direct access to private user key is end-user. [Here](https://security.stackexchange.com/questions/264667/why-does-the-openvpn-server-need-to-keep-clients-private-key) you can find why **OpenVPN Server** doesn't need to keep the client's private key.

When client wants to connect to server, it has to show certificate, signed by CA. But how does this signing work? As it has been mentioned above, only our VPN server is entity, that can generate those certificates for clients. Here is how certificated are generated and signed by **CA's**:

1. Server generates request - **Certificate Signing Request** or just **CSR** - and a pair of public and private key. The **CSR** would contain a copy of the public key and some basic information about the subject.
2. Certificate request is sent to CA server, once the CA is done signing the cert using its private key, the CA would then return the cert. On these certificates there is a copy of the public key of the CA who might issue (sign) your server certificate.

In this particular case, our server will also generate `.ovpn` files, that clients will use in order to connect to server. More information about structure of files with `.ovpn` extention you can find [here](https://serverfault.com/questions/963237/create-own-ovpn-file-from-using-certificate-and-key).

When clients connect to OpenVPN, they use asymmetric encryption (also known as public/private key) to perform a `TLS` handshake. However, when transmitting encrypted VPN traffic, the server and clients use symmetric encryption, which is also known as shared key encryption. So, let's break this down step-by-step, how clients connect to VPN servers:

1. Client wants to connect to server. In order to do that, it shows to server certificate. Remember, that certificate contains public key and signed by **CA**.
2. From now on, server can compare certificates of client and CA and verifies, if certificate actually has been signed by proper **CA** by using its certificate. The certificate of **CA** is stored on server.
3. If everything is matching while this `TLS` handshake, the connection is established and transmitting is starting in this encrypted VPN traffic where the server and clients use symmetric encryption, which is also known as shared key encryption.

---

### Network Diagram and Description

---

### Step-by-step guideline

---

### Repository Source Code Usage

In case if you want to clone this repository and create your own OpenVPN DigitalOcean infrastructure, here is how you can do this.
Just follow next steps:

1. Clone this repository locally on your machine

    ```
    git clone https://github.com/bl4drnnr/openvpn-digitalocean-infrastructure.git
    ```
2. In root folder of the project create file with name `terraform.tfvars`. The name can be whatever you want it to be, but it has to end with `.tfvars`.
3. In this file put next string - `do_token = "<YOUR_DIGITALOCEAN_API_TOKEN>"`. If you don't know where to find it, see [here](https://docs.digitalocean.com/reference/api/create-personal-access-token/). **Make sure generated token has write permissions!**
4. Open up your terminal and navigate to folder with project.
5. Type `terraform plan` and then `terraform apply`. In case if you have changed the name of file with variables you need to specify it by using `-var-file` flag, so, your commands will be looking like this:

    ```
    terraform plan -var-file="<NAME_OF_VARS_FILE>"
    terraform apply -var-file="<NAME_OF_VARS_FILE>"
    ```
    The same situation if you want to destroy built infrastructure:

    ```
    terraform destroy
    terraform destroy -var-file="<NAME_OF_VARS_FILE>"
    ```

---

### References and Contact

- Developer contact - [mikhail.bahdashych@protonmail.com](mailto:mikhail.bahdashych@protonmail.com)
- Terraform official page - [link](https://www.terraform.io/)
- DigitalOcean official page - [link](https://www.digitalocean.com/)
- OpenVPN official page - [link](https://openvpn.net/)
- Terraform documentation - [link](https://developer.hashicorp.com/terraform)
- Terraform with DigitalOcean provider documentation - [link](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs)
- DigitalOcean generation API tokens - [link](https://docs.digitalocean.com/reference/api/create-personal-access-token/)
- Official guideline by DigitalOcean - [link](https://www.digitalocean.com/community/tutorials/how-to-set-up-and-configure-an-openvpn-server-on-ubuntu-20-04)

---

### License

Licensed by [MIT LICENSE](LICENSE).
