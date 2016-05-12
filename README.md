
TDD for Chef Cookbooks: Getting Started

---


Prerequisites:
- ChefDK:
  ```
  curl https://omnitruck.chef.io/install.sh |
    sudo bash -s -- -c current -P chefdk
  eval "$(/opt/chefdk/bin/chef shell-init bash)"
  ```
- git:
  ```
  git clone https://github.com/pburkholder/pdb_motd.git
  cd pdb_motd
  ```
- Vagrant

----

Nordstom's chefDK bootstrap cookbook:
https://github.com/Nordstrom/chefdk_bootstrap

```
curl https://raw.githubusercontent.com/Nordstrom/chefdk_bootstrap/master/bootstrap | bash
```

----

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

Rationale for this cookbook demo:
- Inductive Learners
- Examples > Theory
- Start simple (or even trivial)

----

User story from Legal:

- As user connecting via SSH to a node,
- I expect to see a login message,
- `This system is the property of DevOpsDC`

----

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

---

Plan of Attack:

* <span style="color:red">Look at the tests; try to understand them</span>
* Run the test suite
  * if something breaks, fix it
  * repeat until tests pass
* Do TDD for new ownership with above steps

----

Review ChefSpec default_spec.rb

`spec/unit/recipes/default_spec.rb`

----


```ruby
require 'spec_helper'

describe 'pdb_motd::default' do
  let(:chef_run) {
    ChefSpec::SoloRunner.new.converge(described_recipe)
  }

  it 'should create MOTD' do
    expect(chef_run).to render_file('/etc/motd')
      .with_content('Property of DevOpsDC')
  end
end
```

----

Review Integration default_spec.rb

`test/integration/default/inspec/default_spec`

----

```ruby
require 'inspec'

describe file('/etc/motd') do
  its(:content) { should match(/Property of DevOpsDC/) }
end
```

----

Rake default task:

```
rake -n
** Invoke default (first_time)
** Invoke cop (first_time)
** Execute (dry run) cop
** Invoke foodcritic (first_time)
** Execute (dry run) foodcritic
** Invoke spec (first_time)
** Execute (dry run) spec
** Execute (dry run) default
```

---

Plan of Attack:

* Look at the tests; try to understand them
* <span style="color:red">Run the test suite</span>
  * if something breaks, fix it
  * repeat until tests pass
* Do TDD for new ownership with above steps

----

Demo - `rake`

----

Demo - `rake kitchen`

---

### Fixing borked stuff

```
kitchen login
/opt/chef/embedded/bin/chef-client \
  -z -c /opt/kitchen/client.rb \
  -j /opt/kitchen/dna.json -l warn -F doc
```

---

Plan of Attack:

* Look at the tests; try to understand them
* Run the test suite
  * if something breaks, fix it
  * repeat until tests pass
* <span style="color:red">Do TDD for new ownership with above steps</span>

----

Demo

---

Recap: Plan of Attack:

* Look at the tests; try to understand them
* Run the test suite
  * if something breaks, fix it
  * repeat until tests pass
* Do TDD for new content with above steps

----

Summary:

* Chef is Ruby
* We use TDD when developing Ruby, including
  * Rubocop/Foodcritic: style
  * Rspec/ChefSpec: unit testing
  * Test-Kitchen: integration testing

---

DISCUSSION: Why does Rakefile use shell commands instead of Ruby tasks?

So beginners try each of the commands in isolation, e.g.:

```shell
rubocop
rspec
foodcritic .
```

---

Fini.

---

Presentation prerequisites (for OsX)

```
brew install npm
npm install -g reveal-md
reveal-md README.md
```
