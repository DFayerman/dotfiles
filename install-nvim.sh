# where's istalled current version?
which nvim

# what's current version?
nvim -v

# make tmp folder
mkdir -p ~/tmp
cd ~/tmp

if [-d "neovim"]; then
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
nvimn
