**Oracle-18c-db-in-Windows-docker-container**

Downloaded from Oracle WINDOWS.X64_180000_db_home.zip bundle, the main package used for this project

Used as a template this official article from Oracle
  https://www.oracle.com/technetwork/topics/dotnet/tech-info/oow18windowscontainers-5212844.pdf
  
Downloaded vcredist_x64.exe, this package is mentioned in Oracle's guide and is part of their docker file

Created an Oracle 18c response file for this task
  Uploaded

Created a docker file for this task
  Uploaded

Image Build Log

PS E:\docker\dockerfiles\18c> docker image build -t 2016oracle18c -f dockerfile .
Sending build context to Docker daemon  14.43GB

[WARNING]: Empty continuation line found in:
    RUN powershell.exe -Command $ErrorActionPreference = 'Stop'; Start-Process c:\vcredist_x64.exe -ArgumentList '/install /passive /norestart ' -Wait ; Remove-Item c:\vcredist_x64.exe -Force

[WARNING]: Empty continuation lines will become errors in a future release.

Step 1/15 : FROM mcr.microsoft.com/windows/servercore:1809
 ---> 29a2c2cb7e4d

Step 2/15 : COPY /WINDOWS.X64_180000_db_home.zip c:/data/db_home.zip
 ---> f6d19dce4747

Step 3/15 : RUN powershell -command Expand-Archive c:\\data\\db_home.zip -DestinationPath c:\\data\\db_home
 ---> Running in 06ef4c07b6e1
Removing intermediate container 06ef4c07b6e1
 ---> e27b29040c72

Step 4/15 : RUN setx path ".;c:\data\db_home\Bin;%path%;"
 ---> Running in 1874da4f8360

SUCCESS: Specified value was saved.
Removing intermediate container 1874da4f8360
 ---> fa3f47226ce3

Step 5/15 : ENV ORACLE_HOME c:\\data\\db_home
 ---> Running in 5ff2a8bb3454
Removing intermediate container 5ff2a8bb3454
 ---> ad0594034e9a

Step 6/15 : COPY /vcredist_x64.exe c:/vcredist_x64.exe
 ---> f3678d4aa96a

Step 7/15 : RUN powershell.exe -Command $ErrorActionPreference = 'Stop'; Start-Process c:\vcredist_x64.exe -ArgumentList '/install /passive /norestart ' -Wait ; Remove-Item c:\vcredist_x64.exe -Force
 ---> Running in 7f0de0f7e21b
Removing intermediate container 7f0de0f7e21b
 ---> addd50dc5b5e

Step 8/15 : COPY db.rsp c:\\data\\db.rsp
 ---> d6b11758ef9c

Step 9/15 : RUN c:\data\db_home\setup.bat -silent -noconfig -skipPrereqs -responseFile  c:\data\db.rsp
 ---> Running in b0e3067cf4df

Launching Oracle Database Setup Wizard...

[WARNING] [INS-35810] You have selected to use Built-in Account for installation and configuration of Oracle Home. Oracle recommends that you specify a Windows User Account with limited privilege to install and configure a secure Oracle Home.
   ACTION: Specify a Windows User Account.

[FATAL] [INS-35180] Unable to check for available memory.
*ADDITIONAL INFORMATION:*

Exception details
 - PRVG-1901 : failed to setup CVU remote execution framework directory "C:\Users\ContainerAdministrator\AppData\Local\Temp\InstallActions2019-05-17_11-21-01AM\CVU_18.0.0.0.0_ContainerAdministrator\" on nodes "b0e3067cf4df" Please select a different work area for the framework b0e3067cf4df : PRKN-1014 : Failed to execute remote command "C:\Users\ContainerAdministrator\AppData\Local\Temp\InstallActions2019-05-17_11-21-01AM\CVU_18.0.0.0.0_ContainerAdministrator\\exectask.exe" on node "b0e3067cf4df".Failed during connecting to service b0e3067cf4df : Failed during connecting to service Version of exectask could not be retrieved from node "b0e3067cf4df"


Removing intermediate container b0e3067cf4df
 ---> 0e9631cca03f

Step 10/15 : ENV ORACLE_HOME c:\\data\\db_home
 ---> Running in ce4bdf9b23e5
Removing intermediate container ce4bdf9b23e5
 ---> cd766e6884ae

Step 11/15 : ENV ORACLE_SID orclcdb
 ---> Running in f431c81aa1b4
Removing intermediate container f431c81aa1b4
 ---> 145dbde853d8

Step 12/15 : ENV CLASSPATH c:\\data\\db_home\\jlib;c:\\data\\db_home\\rdbms\\jlib;
 ---> Running in 21a5173efe1d
Removing intermediate container 21a5173efe1d
 ---> 320eb846c4c2

Step 13/15 : EXPOSE 5500 1521
 ---> Running in 42933e9f364e
Removing intermediate container 42933e9f364e
 ---> acc3b1b1b045

Step 14/15 : COPY post_install.bat c:/data/post_install.bat
 ---> e8d4930df119

Step 15/15 : CMD ["c:/data/post_install.bat"]
 ---> Running in c1917b182a2c
Removing intermediate container c1917b182a2c
 ---> ca097c5a3bbb
Successfully built ca097c5a3bbb
Successfully tagged 2016oracle18c:latest
