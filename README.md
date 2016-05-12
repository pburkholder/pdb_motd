
TDD for Chef Cookbooks: Getting Started

---

User story:

- As a node's SSH login user,
- I expect to see a login message,
- `This system is the property of DevOpsDC`

---

Prerequisites:
- ChefDK:
  ```
  curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -c current -P chefdk
  eval "$(/opt/chefdk/bin/chef shell-init bash)"
  ```
- git:
  ```
  git clone https://github.com/pburkholder/pdb_motd.git; cd pdb_motd
  ```
- Docker Toolbox, then
 ```
 docker-machine create --driver virtualbox default
 eval "$(docker-machine env default)"
 ```

---

The last developer had a 1/2 completed cookbook:
* `recipes/default.rb` with attributes for `path`, `message`:
   ```
   file node['motd']['path'] do
     content node['motd']['message']
   end
   ```
* `Rakefile` with test tasks
* Tests in:
   ```
   spec/unit/recipes/default_spec.rb
   test/integration/default/inspec/default_spec.rb
   ```

---

Plan of Attack:

* Look at the tests; try to understand them
* Run the test suite
  * if something breaks, fix it
  * repeat until tests pass
* Do TDD for new ownership with above steps

----

Review ChefSpec default_spec.rb

----

Review Integration default_spec.rb

---

Review Rake tasks

---




This assumed you have ChefDK 0.3.0 or higher installed

EXAMPLE: Run 'rake', then fix each of the offense, and compare to `motd_fixed`

If you can,
* install VirtualBox from https://www.virtualbox.org/wiki/Downloads
* install Vagrant from https://www.vagrantup.com/downloads.html

Now:
1. run `kitchen converge`, then `kitchen verify`
2. fix issues
3. repeat at 1. until no issues


DISCUSSION: Why does Rakefile use shell commands instead of Ruby tasks?

So beginners try each of the commands in isolation, e.g.:

```shell
rubocop
rspec
foodcritic .
```


---

# Presentation prerequisites (for OsX)

```
brew install npm
npm install -g reveal-md
reveal-md README.md
```

# ToDo

- inspec
-
