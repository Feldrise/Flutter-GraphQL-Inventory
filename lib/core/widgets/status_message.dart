
import 'package:fluent_ui/fluent_ui.dart';

enum GQLStatusMessageType { error, success, info }

class GQLStatusMessage extends StatelessWidget {
  const GQLStatusMessage({
    Key? key, 
    this.type = GQLStatusMessageType.error, 
    this.title, 
    this.message, 
    this.children
  }) : super(key: key);
  
  final GQLStatusMessageType type;
  final String? title;
  final String? message;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    late Color backgroundColor;

    if (type == GQLStatusMessageType.error) {
      backgroundColor = Colors.red;
    }
    else if (type == GQLStatusMessageType.success) {
      backgroundColor = Colors.green;
    }
    else /* if (type == BuStatusMessageType.info) */ {
      backgroundColor = Colors.blue;
    }

    return DefaultTextStyle(
      style: const TextStyle(color: Colors.white),
      child: Container(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null && title!.isNotEmpty) ...{
              Text(title!, style: const TextStyle(fontWeight: FontWeight.bold),),
              const SizedBox(height: 15,),
            },
            
            if (message != null && message!.isNotEmpty) ...{
              Text(message!),
              const SizedBox(height: 15,)
            },

            if (children != null && children!.isNotEmpty) ...{
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children!,
              ),
              const SizedBox(height: 15,)
            }
          ],
        ),
      ),
    );
  }
}