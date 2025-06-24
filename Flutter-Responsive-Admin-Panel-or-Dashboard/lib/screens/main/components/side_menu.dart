import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../products/product_screen.dart';

// class SideMenu extends StatelessWidget {
//   const SideMenu({
//     Key? key,
//   }) : super(key: key);

class SideMenu extends StatelessWidget {
  final Function(String)? onMenuSelected;

  const SideMenu({Key? key, this.onMenuSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
          DrawerListTile(
            title: "Bảng điều khiển",
            svgSrc: "assets/icons/bangdieukhien.svg",
            press: () {},
          ),
          // DrawerListTile(
          //   title: "Sản phẩm",
          //   svgSrc: "assets/icons/sanpham.svg",
          //   press: () {
          //     Navigator.push(
          //   context,
          //     MaterialPageRoute(builder: (context) => const ProductScreen()),
          //     );
          //   },
          // ),
          // Sản phẩm đã chỉnh sửa để gọi hàm onMenuSelected
          DrawerListTile(
            title: "Sản phẩm",
            svgSrc: "assets/icons/sanpham.svg",
            press: () {
              if (onMenuSelected != null) {
                onMenuSelected!("Sản phẩm");
              }
            },
          ),
          DrawerListTile(
            title: "Đơn hàng",
            svgSrc: "assets/icons/donhang.svg",
            press: () {
              if (onMenuSelected != null) {
                onMenuSelected!("Đơn hàng");
              }
            },
          ),
          // DrawerListTile(
          //   title: "Chi tiết đơn hàng",
          //   svgSrc: "assets/icons/chitietdonhang.svg",
          //   press: () {},
          // ),
          DrawerListTile(
            title: "Chi tiết đơn hàng",
            svgSrc: "assets/icons/chitietdonhang.svg",
            press: () {
              if (onMenuSelected != null) {
                onMenuSelected!("Chi tiết đơn hàng");
              }
            },
          ),
          // DrawerListTile(
          //   title: "Giỏ hàng",
          //   svgSrc: "assets/icons/giohang.svg",
          //   press: () {},
          // ),
          DrawerListTile(
            title: "Giỏ hàng",
            svgSrc: "assets/icons/giohang.svg",
            press: () {
              if (onMenuSelected != null) {
                onMenuSelected!("Giỏ hàng");
              }
            },
          ),
          DrawerListTile(
            title: "Người dùng",
            svgSrc: "assets/icons/nguoidung.svg",
            press: () {
              if (onMenuSelected != null) {
                onMenuSelected!("Người dùng");
              }
            },
          ),
          // DrawerListTile(
          //   title: "Địa chỉ",
          //   svgSrc: "assets/icons/diachi.svg",
          //   press: () {},
          // ),
          DrawerListTile(
            title: "Địa chỉ",
            svgSrc: "assets/icons/diachi.svg",
            press: () {
              if (onMenuSelected != null) {
                onMenuSelected!("Địa chỉ");
              }
            },
          ),
          // DrawerListTile(
          //   title: "Danh sách yêu thích",
          //   svgSrc: "assets/icons/danhsachyeuthich.svg",
          //   press: () {},
          // ),
          DrawerListTile(
            title: "Danh sách yêu thích",
            svgSrc: "assets/icons/danhsachyeuthich.svg",
            press: () {
              if (onMenuSelected != null) {
                onMenuSelected!("Danh sách yêu thích");
              }
            },
          ),
          // DrawerListTile(
          //   title: "Đánh giá",
          //   svgSrc: "assets/icons/danhgia.svg",
          //   press: () {},
          // ),
          DrawerListTile(
            title: "Đánh giá",
            svgSrc: "assets/icons/danhgia.svg",
            press: () {
              if (onMenuSelected != null) {
                onMenuSelected!("Đánh giá");
              }
            },
          ),
          // DrawerListTile(
          //   title: "Thanh toán",
          //   svgSrc: "assets/icons/thanhtoan.svg",
          //   press: () {},
          // ),
          DrawerListTile(
            title: "Thanh toán",
            svgSrc: "assets/icons/thanhtoan.svg",
            press: () {
              if (onMenuSelected != null) {
                onMenuSelected!("Thanh toán");
              }
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: ColorFilter.mode(Colors.white54, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
