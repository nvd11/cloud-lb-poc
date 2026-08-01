1.所以l4的lb 不支持安装ssl cert吗?


那么我们普通mig 里的lb 是哪一种?

gcp 的instance group是不是分为mig 和 unmig?

你先帮我build 一个 同alicevm 规格的新vm , 要求只有internal ip 没有public ip

要求用tf 代码创建, 放在tf-infra 内

用于我们后面的poc


你看看我的terraform-repo 里面的state file 放到哪里的?



但按我的对代码的理解是

realth check 包含 port
backend 包含 health check 和protocol 和target ip


forward rule包含 ip 和 backende

用什么命令来分别列出forwarding rule, hc 和backend 的信息?

帮我编写一份专业的md博客, 不要有ai 痕迹

详细描述 gcp l4 lb 的组件构成, 组件描述 和组件之间的关系. 可以用我们的实验例子加以说明

要加上l4 和l7的区别

要提及我们聊过的所有问题点

mdfile save 到当前repo的docs/ 和我的repo my-blogs

========================
好, 接下来我们研究下l7 lb

首先是否l7lb 只能代理具体的http 服务, 而不能是一台vm or ip?
==========
你是说l7 lb 代理的也是vm? 只要vm里运行了htttp服务?  也需要知道具体的port吗? 怎么可能?


那么既然l7代理的是vm(ip)+ port, 那么它代理的就是具体的http服务不是吗? 为何你上面说的是代理了vm??


=================