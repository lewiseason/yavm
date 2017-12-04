Then(/^the output should be valid YAML$/) do
  expect do
    YAML.load(last_command_started.output)
  end.not_to raise_error
end

Then(/^the output should be valid JSON$/) do
  expect do
    JSON.load(last_command_started.output)
  end.not_to raise_error
end

Then(/^the json should contain (major|minor|patch)=(.*?)$/) do |key, value|
  json = JSON.load(last_command_started.output)

  expect(json[key]).to eq(value.to_i)
end

Then(/^the json should contain (special|meta)="(.*?)"$/) do |key, value|
  json = JSON.load(last_command_started.output)

  expect(json[key]).to eq(value)
end
