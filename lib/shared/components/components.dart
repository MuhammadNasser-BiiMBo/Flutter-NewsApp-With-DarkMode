import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:untitled/layout/news_app/cubit/cubit.dart';

import '../../modules/web_view/web_view.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  required VoidCallback function,
  required String text,
  bool isUpperCase = true,
  double radius = 0,
}) =>
    Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: background,
        ),
        height: 50,
        width: width,
        child: MaterialButton(
            onPressed: function,
            child: Text(
              isUpperCase ? text.toUpperCase() : text,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Arial',
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            )));

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onTap,
  Function? onChange,
  required String label,
  required IconData prefix,
  required Function validate,
  bool isPassword = false,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      enabled: isClickable,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onTap: () {
        onTap!();
      },
      validator: (s) {
        validate(s);
      },
      onChanged: (s) {
        onChange!(s);
      },
      decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(prefix),
          suffixIcon: suffix != null
              ? IconButton(
                  icon: Icon(suffix),
                  onPressed: () {
                    suffixPressed!();
                  },
                )
              : null,
          border: const OutlineInputBorder()),
    );

Widget buildArticleItem(article, context,index) => Builder(builder: (context) {
      return Container(
        color: NewsCubit.get(context).businessSelectedItem==index&&NewsCubit.get(context).isDesktop?Colors.grey[300]:null,
        child: InkWell(
          onTap: () {
            //article['url']
            // navigateTo(context, WebViewScreen(article['url']));
            NewsCubit.get(context).selectBusinessItems(index);
          },
          onDoubleTap: (){
            navigateTo(context, WebViewScreen(article['url']));

          },
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                article['urlToImage'] != null
                    ? Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage('${article['urlToImage']}'),
                              fit: BoxFit.cover),
                        ),
                      )
                    :  const SizedBox(
                        width: 120,
                        height: 120,
                        child: Icon(Icons.newspaper,size: 70,),
                      ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: SizedBox(
                    height: 120,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            '${article['title']}',
                            style: Theme.of(context).textTheme.bodyText1,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          '${article['publishedAt']}',
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });

Widget mySeparator() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0),
      child: Container(
        height: 1,
        width: double.infinity,
        color: Colors.grey,
      ),
    );

Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
      condition: list.isNotEmpty,
      builder: (context) => ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildArticleItem(list[index], context,index),
          separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsetsDirectional.only(start: 20.0),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey,
                ),
              ),
          itemCount: list.length),
      fallback: (context) => isSearch
          ? Container()
          : const Center(child: CircularProgressIndicator()),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
