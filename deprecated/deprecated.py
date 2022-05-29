#separate the .mpt file and write in different files
def data_cleaner(filepath):
    '''clean the raw data and separate into different parts'''
    ## open text file
    with open(filepath, 'r+') as f:
        file_contents = f.read()
    ## split the text
    text = file_contents.split('\n\n')

    if 'GEIS' in filepath:
        labor_type = 'GEIS'
    else:
        if 'GCPL6' in filepath:
            labor_type = 'GCPL6'

    os.makedirs('data/'+labor_type, exist_ok=True)

    '''setting data'''
    setting = text[2]
    setting = setting.split('Cycle Definition : Charge/Discharge alternance\n')[1]
    ## convert ',' to '.' for decimal
    setting = setting.replace(',','.')
    tmp = []
    for t in setting.split('\n'):
        tmp.append(re.split(r'\s{3,}', t.strip()))
    setting = tmp
    setting = np.transpose(setting)
    #setting = pd.read_table(setting,header=None,engine='python').T
    with open("data/"+labor_type+"/setting.csv", "w",encoding='utf-8') as text_file:
        writer = csv.writer(text_file)
        writer.writerows(setting)


    '''loop data'''
    tmp = []
    for t in text[3].split('\n'):
        tmp.append([int(s) for s in str(t).split() if s.isdigit()])
    tmp =tmp[1:]
    loop_data = tmp
    with open("data/"+labor_type+"/loop_data.csv", "w",encoding='utf-8') as text_file:
        writer = csv.writer(text_file)
        writer.writerows(loop_data)


    '''labor data'''
    ## convert ',' to '.' for decimal
    labor_data = text[-1].replace(',','.')
    with open("data/"+labor_type+"/labor_data.csv", "w",encoding='utf-8') as text_file:
        text_file.write(labor_data)






#create table in Mysql, pd.to_sql can do same thing
def table_define_sql(dataframe,table_name):
    columns = dataframe.columns
    col_types = []
    for col in columns:
        col_types.append(type_check(col))
    create_stement='CREATE TABLE '+table_name + '('
    i=0
    while i< len(columns)-1 :

        create_stement =create_stement +'`'+columns[i]+'`' +'  '+col_types[i]+' ,'
        i=i+1

    create_stement =create_stement +'`'+columns[i]+'`' +'  '+col_types[i]+' );'
    return create_stement


#define the datatype in Mysql
def type_check(column):
    if column in ['flags', 'Ns','half cycle','I Range'] :
        return 'INT'
    elif column  in ['time/s','dQ/mA.h','(Q-Qo)/mA.h','control/V/mA','Ewe/V','Q charge/discharge/mA.h',]:
        return 'FLOAT'
