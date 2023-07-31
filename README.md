# smashing

## Installation

The project uses Ruby 3. 
Make sure you have Ruby 3 installed on your system before proceeding with the following steps.

1. Clone the repository:

```bash
git clone https://github.com/mykhailopavliv5/smashing.git
```

2. Navigate to the project directory:

```bash
cd smashing
```

3. Install dependencies using Bundler:

```bash
bundle install
```

## Usage

The main file for running the project is located in the `lib` directory. You can run the project with the following command:

```bash
./lib/smashing.rb -month 112020 -resolution 800x600
```

Make sure to replace `112020` and `800x600` with the desired month and resolution, respectively.

## Running Tests

The project includes RSpec tests to ensure its correctness. You can run the tests using the following command:

```bash
bundle exec rspec spec
```

This command will execute the test cases defined in the `spec` directory and provide you with the test results.
