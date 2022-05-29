#!/usr/bin/env python
# coding: utf-8

# In[14]:


# thanks to echemdata (https://github.com/echemdata/galvani) 
# for source code of converting mpr files to python readable file.


# In[15]:


from galvani import BioLogic
import pandas as pd
import os


# In[16]:


# search mpr in current directory.
def searchmpr(datapath='.'):
    files = []
    for file in os.listdir(datapath):
        if file.endswith(".mpr"): # take all the files that ends with .mpr format and append the file into the list
            if datapath != '.':
                files.append(datapath+'\\'+file)
            else:
                files.append(file)
    return files # return list of files with .mpr format


# In[23]:


# convert mpr to pandas dataframe
def convertToPandasDF(mprfiles):
    # if only 1 file
    if isinstance(mprfiles, str):
        mpr_file = BioLogic.MPRfile(mprfiles)
        df = pd.DataFrame(mpr_file.data)
        return df
    
    # multiple files in a list
    mpr_files = []
    for file in mprfiles:
        mpr_files.append(BioLogic.MPRfile(file))
    
    dataframes = []
    for convertedMPR in mpr_files:
        dataframes.append(pd.DataFrame(convertedMPR.data))
    return dataframes


# In[24]:


def mpr_pandas(datapath):
    files = searchmpr(datapath)
    dfs = convertToPandasDF(files)
    return dfs





