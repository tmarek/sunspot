require File.join(File.dirname(__FILE__), 'spec_helper')

describe 'indexing' do
  it 'should index non-multivalued field with newlines' do
    lambda do
      Sunspot.index!(Post.new(:title => "A\nTitle"))
    end.should_not raise_error
  end

  it 'should correctly remove by model instance' do
    post = Post.new(:title => 'test post')
    Sunspot.index!(post)
    Sunspot.remove!(post)
    Sunspot.search(Post) { with(:title, 'test post') }.results.should be_empty
  end

  it 'should correctly delete by ID' do
    post = Post.new(:title => 'test post')
    Sunspot.index!(post)
    Sunspot.remove_by_id!(Post, post.id)
    Sunspot.search(Post) { with(:title, 'test post') }.results.should be_empty
  end
end