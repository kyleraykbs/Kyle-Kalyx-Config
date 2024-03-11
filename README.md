
<a name="readme-top"></a>

<br />
<div align="center">
  <img style="width: 70%;" src="https://github.com/Juiced-Devs/Kalyx-System-Template/assets/44762123/cdffa326-8aa8-4e23-a116-7125b355a938" align="center">

  <h3 align="center">
    Templated Kalyx kickstart system configuration.
  </h3>
</div>

# Setup

This template is structured in a relatively standard hierarchy, with the additon of shared files. This graph explains the structure of this template:

![Template Graph](https://github.com/Juiced-Devs/Kalyx-System-Template/assets/44762123/c65ee856-f2b7-4822-bcba-73cf9e4534cd)

To start configuring the system you need to add and name any systems/users, you can do this at the bottom of ``flake.nix``. By default the flake has one user and one system, feel free to duplicate the lines to create another user/system respectively. You can also add, remove or change roles, the default user has the 'pc' role.

![Flake](https://github.com/Juiced-Devs/Kalyx-System-Template/assets/44762123/fa56d6a8-2730-48dd-b2a1-de57a367fe72)

To finish adding the users, systems or just renaming the defaults, duplicate and rename the hosts and users, then track the files in git.

![Renaming](https://github.com/Juiced-Devs/Kalyx-System-Template/assets/44762123/43693d26-c497-4ca5-9433-be8cee55f5ab)

Finally, drop the contents of your original generated hardware-configuration.nix into your newly created (or renamed) host, inside of its hardware.nix.

![Hardware](https://github.com/Juiced-Devs/Kalyx-System-Template/assets/44762123/1e2b6b5d-5a01-41ea-81c4-422ec8fe5f88)

You can now build the config using ``sudo nixos-rebuild switch --flake /path/to/config/#systemname``.

# Instructions for developers.
For people using and developing main Kalyx, you can use a git submodule to nest a editable version of Kalyx inside your repository, allowing you to pull request the main Kalyx project and make local edits.
1. Clone the repo
2. Add your fork to the submodules, make sure it gets clones into kalyx and make sure to change the url in the provided command: ``git submodule add https://github.com/Your/KalyxFork kalyx``
3. Near the top of the flake.nix change ``url = "https://github.com/Juiced-Devs/Kalyx";`` to ``url = "file:./kalyx?submodules=1";`` and below that line add ``type = "git";``
4. Run ``nix flake update``, (Do this after changing something in the kalyx folder).
5. Follow regular setup.
