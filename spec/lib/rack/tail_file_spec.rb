require 'rack/tail_file'
require 'rack/test'
describe Rack::TailFile do

  include Rack::Test::Methods

  def app
    Rack::TailFile.new root
  end

  let(:root) { './spec/fixtures'}
  let(:file_path) { root + file_name }
  let(:file_name) { "/test.txt" }

  describe "GET" do

    context "when the number of lines required is not specified" do
      let(:file_contents) { File.read(file_path )}

      subject { get file_name }

      it "returns the entire file" do
        subject
        expect(last_response.body).to eq(file_contents)
      end

      it "sets a status of 200" do
        subject
        expect(last_response.status).to eq 200
      end
    end

    context "when a number of lines is specified" do
      let(:file_contents) { File.readlines(file_path).last(2).join }

      subject { get file_name, "lines" => "2" }

      it "returns the last lines" do
        subject
        expect(last_response.body).to eq(file_contents)
      end

      it "sets a status of 206" do
        subject
        expect(last_response.status).to eq 206
      end
    end

    context "when a number of lines is specified that is more than the number of lines in the file" do

      subject { get file_name, "lines" => "50" }
      let(:file_contents) { File.read(file_path )}

      it "returns the entire file" do
        subject
        expect(last_response.body).to eq(file_contents)
      end

      it "sets a status of 200" do
        subject
        expect(last_response.status).to eq 200
      end
    end

    context "when the file does not exist" do
      subject { get "something.txt" }

      it "sets a status of 404" do
        subject
        expect(last_response.status).to eq 404
      end
    end
  end

  describe "HEAD" do

    subject { head file_name }

    context "when the number of lines required is not specified" do
      let(:file_contents) { File.read(file_path )}

      it "returns an empty body" do
        subject
        expect(last_response.body.size).to eq 0
      end

      it "sets a status of 200" do
        subject
        expect(last_response.status).to eq 200
      end
    end

    context "when a number of lines is specified" do
      let(:file_contents) { File.readlines(file_path).last(2).join }

      subject { head file_name, "lines" => "2" }

      it "returns an empty body" do
        subject
        expect(last_response.body.size).to eq 0
      end

      xit "sets a status of 206" do
        subject
        expect(last_response.status).to eq 206
      end
    end

  end

  %w{PUT POST DELETE PATCH}.each do | http_method |

    describe http_method do
      it "returns a 405 Method Not Allowed response" do
        self.send(http_method.downcase.to_sym, "something")
        expect(last_response.status).to eq 405
      end
    end

  end

end