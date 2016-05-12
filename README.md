
TDD for Chef Cookbooks: Getting Started

---

Rationale:
- Inductive Learners
- Examples > Theory
- Start simple (or even trivia)

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
- Vagrant

---

Nordstom's chefDK bootstrap cookbook:
https://github.com/Nordstrom/chefdk_bootstrap

```
curl https://raw.githubusercontent.com/Nordstrom/chefdk_bootstrap/master/bootstrap | bash
```

---

Use 'kitchen-dokken' for testing

- Docker Toolbox, then
 ```
 docker-machine create --driver virtualbox default
 eval "$(docker-machine env default)"
 ```
- In this working dir:
  ```
  chef gem install kitchen-dokken
  export KITCHEN_LOCAL_YAML=.kitchen.dokken.yml
  kitchen create # should do all the background image downloads, takes a while
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

----

Review Rake tasks:

```
rake -T
```

---

Now run the tests


### Integration tests



### Fixing borked stuff

```
kitchen login
/opt/chef/embedded/bin/chef-client -z -c /opt/kitchen/client.rb -j /opt/kitchen/dna.json -l warn -F doc
```

``


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
