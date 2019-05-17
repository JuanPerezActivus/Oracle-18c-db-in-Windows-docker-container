FROM mcr.microsoft.com/windows/servercore:1809

COPY /WINDOWS.X64_180000_db_home.zip c:/data/db_home.zip

RUN powershell -command Expand-Archive c:\\data\\db_home.zip -DestinationPath c:\\data\\db_home

RUN setx path ".;c:\data\db_home\Bin;%path%;"

ENV ORACLE_HOME c:\\data\\db_home

COPY /vcredist_x64.exe c:/vcredist_x64.exe

RUN powershell.exe -Command \

$ErrorActionPreference = 'Stop'; \

Start-Process c:\vcredist_x64.exe -ArgumentList '/install /passive /norestart ' -Wait ; \

Remove-Item c:\vcredist_x64.exe -Force

COPY db.rsp c:\\data\\db.rsp

RUN c:\data\db_home\setup.bat -silent -noconfig -skipPrereqs -responseFile  c:\data\db.rsp

ENV ORACLE_HOME c:\\data\\db_home

ENV ORACLE_SID orclcdb

ENV CLASSPATH c:\\data\\db_home\\jlib;c:\\data\\db_home\\rdbms\\jlib;

EXPOSE 5500 1521 
