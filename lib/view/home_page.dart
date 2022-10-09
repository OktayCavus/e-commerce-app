

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';
import 'package:riverpod_flutter_using/controller/controller.dart';
import 'package:riverpod_flutter_using/view/loading_widget.dart';

final controller = ChangeNotifierProvider((ref) => Controller());

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {

  @override
  void initState() {
    super.initState();
    ref.read(controller).getData();
  }


  @override
  Widget build(BuildContext context) {
    
     var read = ref.read(controller);
    //watch anlık değişiklikleri kontrol eder
    var watch = ref.watch(controller);
    return Scaffold(
      appBar: AppBar(title: Text('Riverpod'),),
      body: loadingWidget(
        isLoading: watch.isLoading,
        child: Padding(
          padding: 20.horizontalP,
          child: Column(
            children: [
              SizedBox(height: 20,),

              Row(children: [
                Expanded(
                  flex: 6,
                  child: OutlinedButton(
                    onPressed: () => read.notSavedButton(), 
                    child: Text('Kullanıcılar ${watch.users.length}'))),
                  Spacer(),
                                Expanded(
                  flex: 6,
                  child: OutlinedButton(
                    onPressed: () => read.savedButton(), 
                    child: Text('Kaydedilenler ${watch.saved.length}'))),
              ],),
              

              SizedBox(height: 20,),

              Expanded(
                child: PageView(
                  controller: watch.pageController,
                  children: [
                    notSaved(watch),
                    saved(watch)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

    ListView saved(Controller watch) {
    return ListView.separated(
            shrinkWrap: true,
            itemBuilder:(context,index){
            return Card(
              shape: RoundedRectangleBorder(borderRadius: 15.allBR),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(watch.saved[index]!.avatar!),
                  radius: 20,
                ),
                title: Text('${watch.saved[index]?.firstName ?? ''} ${watch.saved[index]?.lastName ?? ''}  '),
                subtitle:  Text('${watch.saved[index]?.email ?? ''}'),

                trailing: IconButton(icon: Icon(Icons.remove_circle_outline_outlined),
                onPressed: (){
                  watch.removeUsers(watch.saved[index]!);
                }, ),
            ));
          } ,
          separatorBuilder:(context,index){return const SizedBox(height: 15,);
          } ,
            itemCount: watch.saved.length);
  }

  ListView notSaved(Controller watch) {
    return ListView.separated(
            shrinkWrap: true,
            itemBuilder:(context,index){
            return Card(
              shape: RoundedRectangleBorder(borderRadius: 15.allBR),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(watch.users[index]!.avatar!),
                  radius: 20,
                ),
                title: Text('${watch.users[index]?.firstName ?? ''} ${watch.users[index]?.lastName ?? ''}  '),
                subtitle:  Text('${watch.users[index]?.email ?? ''}'),
                trailing: IconButton(icon: Icon(Icons.send),
                onPressed: (){
                  watch.addSaved(watch.users[index]!);
                }, ),
            ));
          } ,
          separatorBuilder:(context,index){return const SizedBox(height: 15,);
          } ,
            itemCount: watch.users.length);
  }
}