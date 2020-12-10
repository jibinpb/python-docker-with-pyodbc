FROM python:3-buster

RUN apt-get update
RUN apt-get install -y python python-pip gcc g++ build-essential

# Installing Microsoft ODBC driver for SQL Server (Linux)
# https://docs.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-ver15#debian17
ADD mssql-release.list /etc/apt/sources.list.d
ADD microsoft.asc /home
RUN apt-key add /home/microsoft.asc
RUN apt-get update
RUN ACCEPT_EULA=Y apt-get install -y msodbcsql17 unixodbc-dev
RUN pip install pyodbc

RUN mkdir /app
WORKDIR /app
ADD app/*.py /app/

CMD python sqltest.py