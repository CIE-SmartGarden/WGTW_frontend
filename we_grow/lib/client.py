
# ws://192.168.43.144:5679
import asyncio
import websockets
import ast 
import time

async def message():
    
    async with websockets.connect('ws://192.168.43.144:5679') as websocket:
        
        pin = input('What yours controller pin?: ')
        await websocket.send(pin)
        checking = await websocket.recv()
        print(checking)
        
        if checking == 'Invalid pin, Please try again.':
            return False

        msg = input("What do you want to request: ")
        await websocket.send(msg)
        
        check = await websocket.recv()
        
        if msg == 'data':
            if check == 'no data': print(check)
                #return False
            
            else:
                dataCollection = ast.literal_eval(check)
                print(dataCollection) #convert to str to list
                #return dataCollection

        elif msg == 'start':
            
            if check == 'Please try again':
                print('already planted!')
                return False
            
            print('Plant\'s list: ', check)
            plant = input("What plant do you want to plant: ")
            await websocket.send(plant)
            message = await websocket.recv()
            print(message)
        
        elif msg == 'setting':
            
            if check == 'Please start the machine': print(check)
            
            else: code = await websocket.recv()
                
        elif msg == 'setting':
            setting = input("What do you want to change?: ")
            await websocket.send(setting)
            
            if setting == 'frequent checking':
                frequent = input("How many seconds? (minimum 5): ")
                await websocket.send(frequent)
                print(await websocket.recv())
                
            elif setting == 'reset':
                print(await websocket.recv())
                
            else: print(await websocket.recv())
                
        else: print(check)
            #return False

check = False
while check != None:
    check = asyncio.get_event_loop().run_until_complete(message())