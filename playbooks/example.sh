################################################################
apt update -y && apt install -y git clang automake autoconf libtool pkg-config gettext perl python3 flex bison gperf checkinstall curl debhelper libcrypto++-dev libcurl4 libcurl4-openssl-dev libgcrypt20-dev libssl-dev libssl3 libsystemd-dev openssl

git clone https://github.com/strongswan/strongswan.git

cd strongswan/
./autogen.sh




https://download.strongswan.org/strongswan-6.0.0.tar.bz2

./configure --prefix=/usr --sysconfdir=/etc --libexecdir=/usr/libexec --with-systemdsystemunitdir=/usr/lib/systemd/system --enable-stroke

make && sudo make install

################################################################

./configure --prefix=/usr --sysconfdir=/etc --libexecdir=/usr/libexec --with-systemdsystemunitdir=/usr/lib/systemd/system --enable-stroke --enable-starter    && make ##&& sudo make install















