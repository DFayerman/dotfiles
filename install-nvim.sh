# install Neovim nightly or upgrade
which nvim
nvim -v
mkdir -p ~/tmp
cd ~/tmp

if [ -d "neovim" ]
then
cd neovim
git pull
else
git clone --depth 1 --branch nightly https://github.com/neovim/neovim.git
cd neovim
fi

# build and install
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

# run
nvim
