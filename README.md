# iac_fuga :shell:

###### Folders, Users and Groups Associated

## A shell program to manage Infrastructure As Code

##### This program is part of the "Linux Experience" course offered by [DIO](https://www.dio.me), taught by [Denilson Bonatti](https://github.com/denilsonbonatti) and tutored by [Venilton Falvo Jr](https://www.linkedin.com/in/falvojr/) and [Camila Cavalcante](https://github.com/cami-la).

------

### Installation:

Once downloaded and unzipped, run...

cd /iac_fuga

chmod +x iac_fuga

### Usage:

./iac_fuga --help

```bash
    Usage: iac_fuga ACTION... OPTION...

    # Folders:
    iac_fuga add folder       # add folder and groups
    iac_fuga remove folder    # remove folder and group
  
    # Users:
    iac_fuga add user         # add user associated to groups
    iac_fuga remove user      # remove user

    # Files:
    iac_fuga export-files     # export files from iac_system to be imported later 
    iac_fuga import-files     # import files from previously exported ones
    iac_fuga install          # Install iac_fuga folders, users and groups on the OS
    iac_fuga uninstall        # uninstall iac_fuga folders, users and groups from OS
  
```

### Instructions:

- Folders cannot exist in the operating system..
- Folders will be associated with folder owner and the created group.
- Users in iac_fuga can only be associated with a group present in the iac_fuga system ( If there is none, insert it before with iac_fuga add folder ).
- You need to be superuser to run iac_fuga actions.



###### License: MIT
