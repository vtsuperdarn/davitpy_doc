def davitpydoc():
    
    import os,string
    docPath = '/davitpy/docs/sphinx'
    projPath = '/davitpy'
    
    with open(docPath+'/index_backup','r') as f:
        index = f.readlines()
    ind = index.index('   :maxdepth: 1\n')
    ind = ind+1
    
    exclude = ['.git','build','sphinx','docs','install','bin','temp.linux-x86_64-2.7']
    for root, dirs, files in os.walk('/davitpy'):
        for name in dirs:
            
            cflg = False
            for level in string.split(root, '/')+[name]:
                if level in exclude: 
                    cflg = True
                    break
            if cflg: continue
            print root,name
            parent = string.replace( string.replace(root, '/', '.'), '.davitpy', '')
            
            if(root == '/davitpy'):
                if(not '   '+name+'\n' in index):
                    index.insert(ind,'\n   '+name+'\n')
                    ind = ind + 1
            else:
                fname = parent[1:]
                with open(os.path.join(docPath, fname+'.rst'), 'r') as f:
                    plines = f.readlines()
                ind = plines.index('   :maxdepth: 2\n')
                ind = ind + 1
                if(not '   '+parent[1:]+'.'+name+'\n' in plines):
                    plines.insert(ind,'\n   '+parent[1:]+'.'+name+'\n')
                    with open(os.path.join(docPath, parent[1:]+'.rst'),'w') as f:
                        f.writelines(plines)
              
            fname = (parent+'.'+name)[1:]
            print 'module.py:: '+fname
            with open( os.path.join( docPath, fname+'.rst' ), 'w' ) as f:
                f.write(fname+'\n')
                f.write('============================\n')
                f.write('.. toctree::\n')
                f.write('   :maxdepth: 2\n')
            
        for name in files:
            #if(root == '/davitpy' or name == 'setup.py' or name[-3:]!='.py'): continue
            if(root == '/davitpy' or name == 'setup.py' or name=="__init__.py" or name[-3:]!='.py'): continue
            cflg = False
            for level in string.split(root, '/')+[name]:
                if level in exclude: 
                    cflg = True
                    break
            if cflg: continue
            print root,name

            parent = string.replace( string.replace(root, '/', '.'), '.davitpy', '')
            fname = os.path.join( docPath, parent[1:]+'.rst' )
            with open(fname, 'r') as f:
                plines = f.readlines()
        
            ind = plines.index('   :maxdepth: 2\n')
            ind = ind + 1
            mod = parent[1:]+'.'+string.replace(name, '.py', '')
            if(not '   '+mod+'\n' in plines):
                plines.insert(ind,'\n   '+mod+'\n')
                with open(os.path.join(docPath, parent[1:]+'.rst'),'w') as f:
                    f.writelines(plines)
            
            fname = parent[1:]+'.'+string.replace( name, '.py', '')
            print 'submodule.py:: '+fname
            with open( os.path.join( docPath, fname+'.rst' ), 'w' ) as f:
                f.write(fname+'\n')
                f.write('============================\n')
                f.write('.. toctree::\n')
                f.write('   :maxdepth: 2\n')
                f.write('\n.. automodule:: '+fname+'\n')
                f.write('   :members:\n')
                f.write('\n.. autoclass:: '+fname+'\n')
                f.write('   :members:\n')
            
            os.system('ln -s '+os.path.join(root, name)+' '+os.path.join(docPath, name))
            
        with open(os.path.join(docPath, 'index.rst'), 'w') as f:
            f.writelines(index)

if __name__ == "__main__":
    davitpydoc()
