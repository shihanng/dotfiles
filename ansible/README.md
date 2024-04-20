```
ASDF_PYAPP_INCLUDE_DEPS=1 mise plugin install ansible https://github.com/amrox/asdf-pyapp.git
mise install

ansible-galaxy install -r requirements.yml
ansible-playbook -K site.yml
```
