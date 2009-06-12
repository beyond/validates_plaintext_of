require File.join(File.dirname(__FILE__),'spec_helper')
 
ActiveRecord::Base.establish_connection({
  :adapter => "sqlite3",
  :database => ":memory:",
})
 
ActiveRecord::Schema.define(:version => 1) do
  create_table :entries, :force=>true do |t|
    t.string :title
    t.string :author
    t.string :comment
    t.timestamps
  end
end
 
class Entry < ActiveRecord::Base
  validates_plaintext_of :title, :message=>'custom'
  validates_plaintext_of :author, :allow_blank => true
  validates_plaintext_of :comment
end
 
describe :validates_plaintext_of do
  it "makes record invalid" do
    entry = Entry.new( :title => "<a>link</a>", :comment => "<script>alert('a')</script>" )
    entry.should_not be_valid
  end

  it "allows blank with allow_blank fields" do
    entry = Entry.new( :title => "link", :comment => "alert('a')" )
    entry.should be_valid
  end

  it "disallows blank without allow_blank fields" do
    entry = Entry.new
    entry.should_not be_valid
  end

  it "adds a custum message" do
    entry = Entry.new( :title => "<a>link</a>" )
    entry.should_not be_valid
    entry.errors[:title].should == "custom"
  end

  it "makes error when text have no end-tag" do
    entry = Entry.new( :title => "<a>link", :comment => "aa" )
    entry.should_not be_valid
  end
end
