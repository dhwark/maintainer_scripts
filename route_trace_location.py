from scapy.all import traceroute
import sys
import requests
from bs4 import BeautifulSoup


# 运行 traceroute 命令
result, _ = traceroute(sys.argv[1], maxttl=30, verbose=False)

# 提取IP地址并去重
ip_addresses = list(set(packet[1].src for packet in result.res))


def location(ip_addresses):
    for i in ip_addresses:
        url = f'https://ip.cn/ip/{i}.html'
        response = requests.get(url)

        # 检查请求是否成功
        if response.status_code == 200:
            # 使用BeautifulSoup解析HTML内容
            soup = BeautifulSoup(response.text, 'html.parser')

            # 使用find方法查找包含tab0_address的<div>标签
            tab0_address_div = soup.find('div', id='tab0_address')

            # 检查是否找到了对应的标签
            if tab0_address_div:
                # 提取tab0_address数据
                tab0_address = tab0_address_div.text.strip()
                print(f"IP:{i} {tab0_address}")
            else:
                print("未找到tab0_address的数据")
        else:
            print(f"请求失败，状态码: {response.status_code}")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f'用法: python {sys.argv[0]} <域名>')
        sys.exit(1)
    location(ip_addresses)