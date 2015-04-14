require 'spec_helper'

describe 'garbo::default' do

  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html

  it "h2o is listening on port 8080" do
    expect(port(8080)).to be_listening
  end
  it "h2o is listening on port 8443" do
    expect(port(8443)).to be_listening
  end

  # describe command('curl https://localhost/assets/images/logo.svg -k -I --compressed 2>&1 | grep Access-Control-Allow-Origin') do
  #   its(:stdout) { should eq "Access-Control-Allow-Origin: *\r\n" }
  # end
end


