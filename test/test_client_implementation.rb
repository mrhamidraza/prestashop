require_relative 'test_helper'

module Prestashop
  module Client
    describe Implementation do

      it "should create instance via create" do 
        Implementation.stubs(:current)
        Implementation.expects(:new)
        Implementation.create '123', '123', user: 'Steve'
      end

      it "should have connection and settings" do 
        Api::Connection.expects(:new).with('123', '123')
        Settings.expects(:new).with({user: 'Steve'})
        Implementation.create '123', '123', user: 'Steve'
      end

      it "should have access to current implementation" do
        Api::Connection.stubs(:new)
        Settings.stubs(:new)

        Implementation.create '123', '123', user: 'Steve'
        Implementation.current.must_be_instance_of Implementation
      end

      it "must be always the same" do
        Api::Connection.stubs(:new)
        Settings.stubs(:new)
        impl = Implementation.create '123', '123', user: 'Steve'

        5.times do 
          Implementation.current.must_equal impl
        end
      end
    end
  end
end