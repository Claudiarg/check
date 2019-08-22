#/bin/sh

echo "Updating the system"
yum update -y

echo "Installing Postgres 9.5"
rpm -iUvh https://download.postgresql.org/pub/repos/yum/9.5/redhat/rhel-7-x86_64/pgdg-centos95-9.5-3.noarch.rpm

yum install -y postgresql95-server postgresql95 postgresql95-contrib

systemctl enable postgresql-9.5

/usr/pgsql-9.5/bin/postgresql95-setup initdb

systemctl start postgresql-9.5

echo "Creating postgres user Admin"
sudo -u postgres createuser -s admindb
su - postgres -c "psql -U postgres -d postgres -c \"ALTER USER admindb WITH password 'TqrpfXx3smAhVByG';\""

echo "Creating databases"
su - postgres -c "psql -U postgres -d postgres -c \"CREATE DATABASE check_server_development OWNER admindb\""
su - postgres -c "psql -U postgres -d postgres -c \"CREATE DATABASE check_server_test OWNER admindb\""
su - postgres -c "psql -U postgres -d postgres -c \"CREATE DATABASE check_server_production OWNER admindb\""


echo "Enabling remote access"
echo "host  all     all     10.1.1.0/24     trust" >> /var/lib/pgsql/9.5/data/pg_hba.conf
sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /var/lib/pgsql/9.5/data/postgresql.conf
systemctl restart postgresql-9.5
