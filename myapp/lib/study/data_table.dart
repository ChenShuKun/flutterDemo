import "package:flutter/material.dart";

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("data tabel "),
      ),
      body: const _StudyDataTable(),
    );
  }
}

class _StudyDataTable extends StatefulWidget {
  const _StudyDataTable({Key? key}) : super(key: key);

  @override
  _StudyDataTableState createState() => _StudyDataTableState();
}

class User {
  String name = "";
  int age = 0;
  String grand = "";
  String address = "";
  bool selected = false;
  User(this.name, this.age, this.address,
      {this.grand = "", this.selected = false});
}

class _StudyDataTableState extends State<_StudyDataTable> {
  List<User> userList = [
    User("张三", 20, "北京", grand: "三年二班", selected: true),
    User("李磊", 17, "Harbin", grand: "三年二班"),
    User("张华", 21, "石家庄", grand: "三年二班"),
    User("张猴", 16, "齐齐哈尔", grand: "三年二班"),
  ];
  List<DataRow> _getDataRows() {
    List<DataRow> list = [];
    for (var i = 0; i < userList.length; i++) {
      User user = userList[i];
      list.add(DataRow(
          selected: user.selected,
          // color: MaterialStateProperty.resolveWith((states) {
          //   return Colors.red;
          // }),
          onSelectChanged: (value) {
            setState(() {
              userList[i].selected = value!;
            });
          },
          cells: [
            DataCell(Text(user.name)),
            DataCell(Text("${user.age}")),
            DataCell(Text(user.grand)),
            DataCell(Text(user.address))
          ]));
    }
    return list;
  }

  bool _sortAscending = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: DataTable(
            showBottomBorder: true,
            sortColumnIndex: 1,
            sortAscending: _sortAscending,
            columns: [
              const DataColumn(label: Text("姓名")),
              DataColumn(
                  numeric: true,
                  onSort: (int columnIndex, bool ascending) {
                    setState(() {
                      _sortAscending = ascending;
                      if (ascending) {
                        userList.sort(((a, b) {
                          return a.age.compareTo(b.age);
                        }));
                      } else {
                        userList.sort(((a, b) => b.age.compareTo(a.age)));
                      }
                    });
                  },
                  label: Text("年龄")),
              const DataColumn(label: Text("班级")),
              const DataColumn(label: Text("地址")),
            ],
            rows: _getDataRows()
            // [
            //   DataRow(cells: [
            //     DataCell(Text("张三")),
            //     DataCell(Text("18")),
            //     DataCell(Text("18"))
            //   ]),
            //   DataRow(cells: [
            //     DataCell(Text("张三")),
            //     DataCell(Text("18")),
            //     DataCell(Text("18"))
            //   ]),
            //   DataRow(cells: [
            //     DataCell(Text("张三")),
            //     DataCell(Text("18")),
            //     DataCell(Text("18"))
            //   ]),
            // ]
            ));
  }
}
