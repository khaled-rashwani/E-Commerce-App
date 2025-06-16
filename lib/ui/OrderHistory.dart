import 'package:EZ_Shop/shared/components.dart';
import 'package:EZ_Shop/shared/helperFunctions.dart';
import 'package:EZ_Shop/ui/User/OrderDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/OrderCubit/cubit.dart';
import '../../cubit/OrderCubit/states.dart';
import '../Shared/themes.dart';
import '../models/OrdersModel.dart';

class OrdersHistory extends StatefulWidget {
  @override
  State<OrdersHistory> createState() => _OrdersHistoryState();
}

class _OrdersHistoryState extends State<OrdersHistory> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderCubit()..getOrders(),
      child: BlocConsumer<OrderCubit, OrderStates>(
        builder: (context, state) {
          print('state is: ');
          print(state);
          if (state is GetOrdersSuccessState) {
            OrdersModel _orders = OrderCubit.get(context).ordersModel;
            if (_orders.data!.length != 0) {
              return Scaffold(
                appBar: AppBar(
                  title: Text('My Orders'),
                ),
                body: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Expanded(
                      child: ListView.builder(
                          // shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return _buildOrderItem(
                                _orders.data![index], context);
                          },
                          itemCount: _orders.data!.length),
                    ),
                  ],
                ),
              );
            }
            if (_orders!.data!.length == 0)
              return Scaffold(appBar: AppBar(), body: _buildEmptyOrders());
          }
          if (state is GetOrdersLoadingState)
            return Scaffold(body: buildLoadingWidget());
          if (state is GetOrdersErrorState) {
            return Scaffold(body: buildErrorWidget());
          } else
            return Container();
        },
        listener: (context, state) {},
      ),
    );
  }
}

Widget _buildOrderItem(Data item, context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Material(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      elevation: 1,
      clipBehavior: Clip.hardEdge,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 100,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Order Number: ',style: TextStyle(fontWeight: FontWeight.w300),),
                  Text(item.id.toString(),style: TextStyle(fontWeight: FontWeight.w400),),
                  Spacer(),
                  Text('Date: ',style: TextStyle(fontWeight: FontWeight.w300),),
                  Text(item.createdAt!.substring(0, 10).toString(),style: TextStyle(fontWeight: FontWeight.w400)),
                ],
              ),
              SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [


                  Text('Items : ',style: TextStyle(fontWeight: FontWeight.w300),),
                  Text(item.orderItems!.length.toString(),style: TextStyle(fontWeight: FontWeight.w400)),
                  Spacer(),
                  Text('Total Price: ',style: TextStyle(fontWeight: FontWeight.w300),),
                  Text(item.totalPrice.toString(),style: TextStyle(fontWeight: FontWeight.w400),),

                ],
              ),
             Spacer(),
              Row(
                children: [
                  Text('Status : ',style: TextStyle(fontWeight: FontWeight.w300),),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(
                          Radius.circular(15)),
                      color: item.state==0 ?Colors.amber
                          .withOpacity(0.1):Colors.green
                          .withOpacity(0.1),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Container(
                      margin:
                      const EdgeInsetsDirectional
                          .only(
                          start: 10, end: 8),
                      child: Text(
                        item.state==0?'Pending':'Completed',
                        style: TextStyle(
                            fontWeight:
                            FontWeight.w300,
                            fontSize: 18,
                            color: item.state==0?Colors.amber:Colors.green),
                      ),
                    ),
                  ),
                  Spacer(),
                  IconButton(onPressed: (){
                    NavigateTo(context, OrderDetails(item.orderItems));
                  }, icon: Icon(Icons.remove_red_eye_sharp,size: 22,)),
                ],
              ),

            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildEmptyOrders() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset('images/onBoarding1.png'),
      Text(
        'Your Orders is empty!\nBrowse Our Products and Start Shopping Now!',
        style: TextStyle(fontWeight: FontWeight.w200),
        textAlign: TextAlign.center,
      )
    ],
  );
}



