#!/usr/bin/env python
# coding: utf-8

# In[14]:


# thanks to echemdata (https://github.com/echemdata/galvani) 
# for source code of converting mpr files to python readable file.


# In[15]:


from galvani import BioLogic
import pandas as pd
import numpy as np
import os
import re

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
        cycle_start = mprfiles.split('Cycle')[1].split('_')[0].split('to')[0] #'raw_data\\Cell001_Form_20uA_25T_30RH_Cycle1to10_01_GEIS_CA1.mpr'
        mpr_file = BioLogic.MPRfile(mprfiles)
        df = pd.DataFrame(mpr_file.data)
        #define 'loop_Nr' ,cycle_Nr
        loop_index = mpr_file.loop_index
        loop_Nr = np.zeros(loop_index[-1])
        cycle_Nr = np.zeros(loop_index[-1])
        loop = 0
        cycle = int(cycle_start)
        for i in range(len(loop_index)-1):
            loop_Nr[loop_index[i]:loop_index[i+1]] = loop
            cycle_Nr[loop_index[i]:loop_index[i+1]] = cycle
            loop +=1
            cycle +=1
        loop_Nr = np.array(loop_Nr,dtype='int')
        cycle_Nr = np.array(cycle_Nr,dtype='int')
        df['loop_Nr'] = loop_Nr
        df['cycle_Nr'] = cycle_Nr
        
        return df
    
    # multiple files in a list
    mpr_files = []
    for file in mprfiles:
        mpr_files.append(BioLogic.MPRfile(file))
    cycle_start = mprfiles[0].split('Cycle')[1].split('_')[0].split('to')[0]# since currently all files share same cycle number, just take it once    
    dataframes = []
    if int(cycle_start) ==1:#form data
        for convertedMPR in mpr_files:
            df = pd.DataFrame(convertedMPR.data)
            #define 'loop_Nr'
            loop_index = convertedMPR.loop_index
            loop_Nr = np.zeros(loop_index[-1])
            cycle_Nr = np.zeros(loop_index[-1])
            loop = 0
            cycle = int(cycle_start)
            for i in range(len(loop_index)-1):
                loop_Nr[loop_index[i]:loop_index[i+1]] = loop
                cycle_Nr[loop_index[i]:loop_index[i+1]] = cycle
                loop +=1
                cycle +=1
            loop_Nr = np.array(loop_Nr,dtype='int')
            cycle_Nr = np.array(cycle_Nr,dtype='int')
            df['loop_Nr'] = loop_Nr
            df['cycle_Nr'] = cycle_Nr
            dataframes.append(df)
    else:# cyc data
        mpr_files = np.reshape(mpr_files,(-1,2))
        for [eis,cpl] in mpr_files:
            df_eis = pd.DataFrame(eis.data)
            df_cpl = pd.DataFrame(cpl.data)
            half_cycle = df_cpl['half cycle'].copy()
            unique_half_cycle = np.unique(half_cycle)
            df_cpl['half cycle'] = np.mod(half_cycle,2)#[0,1,2,3,4,5] to [0,1,0,1,0,1]
            df_cpl['loop_Nr'] = np.floor_divide(half_cycle,2)%10#[0,1,2,3,4,5,6,7,8,9,0,1,2,3,4...]
            df_cpl['cycle_Nr'] = np.add(int(cycle_start) , np.floor_divide(half_cycle,2))#[0,1,2,3,4,5,6,7,8,9,10,11,12,13]
            #eis time index
            eis_index = np.where(df_eis['freq/Hz'][:-1].values<df_eis['freq/Hz'][1:].values)[0]
            first_index = 0 
            cycle_Nr = int(cycle_start)
            cycle_array = np.zeros(len(df_eis))
            for end_index in eis_index:
                cycle_array[first_index:end_index+1] = cycle_Nr
                cycle_Nr +=10 #every 10 loop apply one eis
                first_index = end_index+1
            cycle_array[end_index+1:] = cycle_Nr
            cycle_array = np.array(cycle_array,dtype='int')
            df_eis['cycle_Nr'] = cycle_array
            dataframes.append(df_eis)
            dataframes.append(df_cpl)
            
    return dataframes


# In[24]:


def mpr_pandas(datapath):
    files = searchmpr(datapath)
    dfs = convertToPandasDF(files)
    return dfs


def filename_read(path):
    
    index  = ['Cell Nr',
              'Phase Type',
              'Current/μA',
              'Temperature/℃',
              'Relative Humidity/%',
              'Cycle Nr',
              'Technique Step',
              'Technique Type',
              'Channel Nr'
                ]
    frame = pd.DataFrame(columns = index)
    for i in path:
        info = i.split('_')
        value = []
        value.append(re.sub('\D','',info[0]))#cell Nr
        value.append(info[1])#Phase Type
        value.append(re.sub('\D','',info[2]))#current
        value.append(re.sub('\D','',info[3]))#Temperature
        value.append(re.sub('\D','',info[4]))#Relative Humidity
        value.append(re.sub('Cycle','',info[5]))#Cycle number
        value.append(info[6])#Technique Step
        value.append(info[7])#Technique Type
        value.append(re.sub('\D','',info[8]))#Channel Nr
        frame.loc[len(frame)] = value
    
    return frame


