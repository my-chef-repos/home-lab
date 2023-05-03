# encoding: UTF-8

#
# Copyright 2014, Deutsche Telekom AG
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'spec_helper'

describe 'ssh-hardening::unlock' do
  # converge
  cached(:chef_run) do
    ChefSpec::SoloRunner.new.converge(described_recipe)
  end

  # check that the recipes are executed
  it 'runs unlock users command' do
    expect(chef_run).to run_execute('unlock users').with(
      command: "/bin/sed 's/^\\([^:]*:\\)\\!/\\1*/' -i /etc/shadow"
    )
  end
end
