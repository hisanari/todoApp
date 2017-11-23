guard :minitest, test_folders: 'test', all_on_start: false, spring: true do
  watch(%r{^app/views/(.+)/.*\.(erb|haml)$}) \
    { |m| "test/controllers/#{m[1]}_controller_test.rb" }
end
