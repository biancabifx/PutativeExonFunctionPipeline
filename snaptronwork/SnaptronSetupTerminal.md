## How to get Snaptron running in the terminal

#### Install Dependencies
You'll need git, python 2.7, and pip installed. Python 2.7 should come preinstalled on Mac OS

To install pip
```
sudo easy_install pip
```
Check pip version to verify it was installed
```
pip --version
```
Install future, as it's a dependency of the snaptron project.
```
pip install future
```

#### Clone Repo
git clone https://github.com/ChristopherWilks/snaptron-experiments.git
cd snaptron-experiments

#### Test the CLI client
Enter this test query into the terminal once you're in the folder containing the snaptron repo.
This test query came from the quickstart guide found at the referenced links below.

```
 ./qs --region "chr2:29446395-30142858" --filters "samples_count>=100&coverage_sum>=150" 
```
The output from the query above can be directed to a text file by appending `1> filename.txt` to the end.
Adding a .csv extension by renaming the file, and then loading it into r with read.delim() will create a dataframe of the output.
#### References
[Install git on Mac](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
[Install python 2.7 on Mac](https://docs.python-guide.org/starting/install/osx/)
[Install pip on Mac](https://ahmadawais.com/install-pip-macos-os-x-python/) 
[Snaptron User Manual](http://snaptron.cs.jhu.edu/client.html)