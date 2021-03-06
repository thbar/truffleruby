# Copyright (c) 2018 Oracle and/or its affiliates. All rights reserved. This
# code is released under a tri EPL/GPL/LGPL license. You can use it,
# redistribute it and/or modify it under the terms of the:
#
# Eclipse Public License version 1.0, or
# GNU General Public License version 2, or
# GNU Lesser General Public License version 2.1.

require_relative '../../ruby/spec_helper'

describe "The -Xfinalizers.run_on_exit option" do
  it "runs finalizers on exit" do
    code = <<~RUBY
    OBJ = Object.new
    ObjectSpace.define_finalizer(OBJ, -> {
      puts :finalized
      STDOUT.flush
    })
    p :end
    RUBY
    ruby_exe(code, options: "-Xfinalizers.run_on_exit").should == ":end\nfinalized\n"
  end
end
