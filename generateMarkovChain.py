# generates text using Markov Chain
# uses the PyMarkovChain implimetntation: https://pypi.python.org/pypi/PyMarkovChain/
# to install on linux, run "pip install PyMarkovChain" in the shell

# import function
from pymarkovchain import MarkovChain
import re, string 

# first, read in file with training text data (I made mine by getting all my blog text as a .xml, grabbing only the nodes with the actual blog text in them and then scrubbing all html tags)
f = open("extractedText.txt", "r")

# tidy up our text input a bit
textToScrub = f.read()
text = re.sub(r'^https?:\/\/.*[\r\n]*', '', textToScrub, flags=re.MULTILINE) #get rid of urls/links
text = text.replace(u'\xa0', u' ') #throw out those pesky non-breaking spaces

# then create the markov chain generator 
mc = MarkovChain("./markov")
mc.generateDatabase(text) 

# finally, generate some text -- run this command multiple times to generate multiple text strings
for num in range(1,10):
 mc.generateString()
