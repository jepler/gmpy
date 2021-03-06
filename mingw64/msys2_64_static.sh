mkdir $HOME/64
mkdir $HOME/64/src
mkdir $HOME/64/static
mkdir $HOME/64/shared

cd $HOME/64/src

wget https://gmplib.org/download/gmp/gmp-6.2.0.tar.lz
tar xf gmp-6.2.0.tar.lz

wget https://www.mpfr.org/mpfr-current/mpfr-4.1.0.tar.bz2
tar xf mpfr-4.1.0.tar.bz2
cd mpfr-4.1.0/
wget https://www.mpfr.org/mpfr-current/allpatches
patch -N -Z -p1 < allpatches
cd ..

wget ftp://ftp.gnu.org/gnu/mpc/mpc-1.2.0.tar.gz
tar xf mpc-1.2.0.tar.gz

cd gmp-6.2.0/
./configure --prefix=$HOME/64/static --enable-static --disable-shared --enable-fat --with-pic
make
make check
make install
cd ..

cd mpfr-4.1.0/
./configure --prefix=$HOME/64/static --enable-gmp-internals --enable-static --disable-shared --disable-decimal-float --disable-float128 --with-pic --with-gmp=$HOME/64/static
make
make check
make install
cd ..

cd mpc-1.2.0/
./configure --prefix=$HOME/64/static --enable-static --disable-shared --with-pic --with-gmp=$HOME/64/static --with-mpfr=$HOME/64/static
make
make check
make install
cd ..
