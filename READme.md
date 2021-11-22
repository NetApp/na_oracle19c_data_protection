na_oracle19c_data_protection
=========

Organizations are automating their environments to gain efficiencies, accelerate deployments, and reduce manual effort. Configuration management tools like Ansible are being used to streamline enterprise database operations. In this solution, we demonstrate how you can use Ansible to automate the data protection of Oracle with NetApp ONTAP. By enabling storage administrators, systems administrators, and DBAs to consistently and rapidly setup data replication to an offsite data center or to public cloud, you achieve the following benefits:

- Eliminate design complexities and human errors, and implement a repeatable consistent deployment and best practices

- Decrease time for configuration of Intercluster replication, CVO instantiation, and recovery of Oracle databases

- Increase database administrators, systems and storage administrators productivity

- Provides database recovery workflow for ease of testing a DR scenario.

License
-------

By accessing, downloading, installing or using the content in this repository, you agree the terms of the License laid out in [License](LICENSE.TXT) file.

Note that there are certain restrictions around producing and/or sharing any derivative works with the content in this repository. Please make sure you read the terms of the [License](LICENSE.TXT) before using the content. If you do not agree to all of the terms, do not access, download or use the content in this repository.

Requirements for On-Prem to On-Prem
------------

    AWX/Tower
    Ansible v.2.10 and higher
    Python 3
    Python libraries:
      netapp-lib
      xmltodict
      jmespath
  
    ONTAP version 9.8 +
      Two data aggregates
      NFS vlan and ifgrp created
  
    RHEL 7/8
    Oracle Linux 7/8
      Network interfaces for NFS, public (internet) and optional management
      Existing Oracle environment on source, and the equivalent Linux operating system at the destination (DR Site or Public Cloud)
  
Requirements for On-Prem to CVO
------------  
    AWX/Tower
    Ansible v.2.10 and higher
    Python 3
    Python libraries:
      netapp-lib
      xmltodict
      jmespath
  
    ONTAP version 9.8 +
      Two data aggregates
      NFS vlan and ifgrp created
  
    RHEL 7/8
    Oracle Linux 7/8
      Network interfaces for NFS, public (internet) and optional management
      Existing Oracle environment on source, and the equivalent Linux operating system at the destination (DR Site or Public Cloud)
      Set appropriate swap space on the Oracle EC2 instance, by default some EC2 instances are deployed with 0 swap
  
    Cloud Manager/AWS
    AWS Access/Secret Key
    NetApp Cloud Manager Account
    NetApp Cloud Manager Refresh Token
  
Variables
---------

For detailed instructions for running the playbook refer to NetAppDocs https://docs.netapp.com/us-en/netapp-solutions/ent-apps-db/db_protection_awx_automation.html
