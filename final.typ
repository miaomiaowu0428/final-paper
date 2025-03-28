#import "@local/FinalProject:0.1.0":*;
#import "@preview/i-figured:0.2.4";
#show figure: i-figured.show-figure



#show heading: set text(font: ("簡宋","Times New Roman"));
#set heading(numbering: "1.1")
#show heading: content => [#content]
#show heading.where(level: 1): content => [
  #set text(size: 15pt,weight: "black");
  #content
]

#show heading.where(level: 2): set heading(numbering: " 1.1")
#show heading.where(level: 3): set heading(numbering: "  1.1")
#show heading.where(level: 4): set heading(numbering: "   1.1")

#show heading.where(level: 2): content => [
  #set text(size: 14pt,weight: "black");
  #set heading(numbering: "1.1")
  #content
]
#show heading.where(level: 3): content => [
  #set text(size: 13pt,weight: "black");
  #content
]
#show heading.where(level: 4): content => [
  #set text(size: 12pt,weight: "black");
  #content
]
#set page(margin: (top: 3cm,right: 3.6cm,left: 3.6cm,bottom: 3cm),paper: "a4")
#show figure.where(kind: image): set figure(supplement: [图])
#show figure.where(kind: table): set figure(supplement: [表])
#show: content=>[#Text[#content]]





#set page(numbering: "I")
#Center((box(image("media/jxufe.png", height: 0.84375in, width: 3.69792in))))
#v(4em)

#Center[#VerticalTitle("普通本科毕业设计")]

#Center[#Informations[
  基于clap-rs的脚手架工具zino-cli设计与实现
][虚拟现实产业学院
][邱宏扬
][0210278
][软件工程（VR方向）
][2025
][胡冬萍
][副教授
]]







#pagebreak()
#Center[#strong[普通本科生毕业论文（设计）诚信承诺书]]

#align(center)[#set text(font: ("簡宋","Times New Roman"),size: 12pt);#table(
  stroke: 0.6pt,
  columns: (15.85%, 15.64%, 11.93%, 18.86%, 14.98%, 22.75%),
  align: (center,auto,center,center,center,auto,),
  table.header(table.cell(align: center, colspan: 2)[毕业论文（设计）题
    目], table.cell(align: center, colspan: 4)[基于clap-rs的脚手架工具zino-rs的设计与实现],),
  table.hline(),
  table.cell(align: center)[学生姓名], [邱宏扬], table.cell(align: center)[专　业], table.cell(align: center)[软件工程（VR方向）], table.cell(align: center)[学
  号], [0210278],
  table.cell(align: center)[指导老师], table.cell(colspan: 2)[胡冬萍], table.cell(align: center)[职
  称], table.cell(colspan: 2)[副教授],
  table.cell(align: center)[所在学院], table.cell(align: center, colspan: 5)[虚拟现实产业学院],
  table.cell(align: center, colspan: 6)[
    #v(4em)
    #strong[诚信承诺]

    #Text(box(height: 10em)[
    #set align(horizon)
    #set par(first-line-indent: (amount: 2em,all: true)) 
    本人慎重承诺和声明：

    我承诺在毕业论文（设计）活动中遵守学校有关规定，恪守学术规范，在本人的毕业论文中未剽窃、抄袭他人的学术观点、思想和成果，未篡改研究数据，如有违规行为发生，我愿承担一切责任，接受学校的处理。
    
    ])
    #v(20em)
    #SignDate[学生（签名）：][2025年04月1日]

  ],
)]
#pagebreak()


#摘要标题

#摘要正文[随着互联网技术的发展，Web API 的安全与性能至关重要。Rust
语言凭借出色的性能和强大的安全性在后端服务开发领域备受青睐，Zino
开发框架也为 Rust 的 Web 开发提供了有力支持。

然而Zino
框架缺少完善的脚手架工具，制约了其推广应用。本设计旨在开发一款基于 clap
\- rs 的 Zino 框架专用脚手架工具 zino - cli。通过深入分析 Zino
框架在项目初始化、依赖管理和自动化部署等方面的痛点，运用 Rust
语言特性和相关技术栈，实现项目快速初始化、高效依赖管理和自动化持续集成部署等功能。该工具不仅能显著提升
Zino 框架的开发效率、降低开发成本，还能保障 Web
项目的安全性和稳定性，对推动 Rust 语言在 Web
开发领域的应用具有重要意义。

#[ #set text(font: "Hei");
  【关键词】
  ]脚手架工具 CI/CD Rust语言 Zino框架]

#AbstractTitle

#Abstract[With the development of Internet technology, the security and
performance of Web APIs are of crucial importance. The Rust programming
language has gained significant popularity in the field of back - end
service development due to its excellent performance and strong security
features. The Zino development framework also provides powerful support
for Rust - based Web development.

However, the Zino framework lacks a complete set of scaffolding tools,
which restricts its widespread adoption. This design aims to develop a
dedicated scaffolding tool, zino - cli, for the Zino framework based on
clap - rs. By deeply analyzing the pain points of the Zino framework in
aspects such as project initialization, dependency management, and
automated deployment, and leveraging the features of the Rust language
and relevant technology stacks, functions such as rapid project
initialization, efficient dependency management, and automated
continuous integration and deployment are realized. This tool can not
only significantly improve the development efficiency of the Zino
framework and reduce development costs but also ensure the security and
stability of Web projects. It is of great significance for promoting the
application of the Rust language in the field of Web development.

#[#set text(font: "Arial")
*【Key Words】*]Scaffolding tool; CI/CD; Rust language; Zino framework]
#pagebreak()


#[
  #目录标题
  #show heading: set heading(numbering: none)
  #outline(title: [],indent: outlineIndent) 
]



#set page(numbering: "1")
#counter(page).update(1)
#counter(heading).update(0)

= 绪论
== 研究背景

#Text[随着互联网技术的储蓄发展，互联网用户规模呈现不断增长的趋势，各类网络应用的访问量也与日俱增。在这样的大背景下WebApi作为连接前端应用与后端服务的桥梁，其安全和性能的重要性愈发凸显。任何WebApi的安全漏洞都可能导致用户数据泄露、系统被攻击等严重后果，而性能不佳则会导致用户体验下降，造成用户流失，这对互联网企业来说是难以承受的损失。]


== 领域研究现状
#Text[Rust语言以其出色的性能与周密的安全性保证在后端开发领域崭露头角，成为众多互联网公司的新宠，Rust语言的内存安全机制能够在编译阶段就避免诸如缓冲区、悬空指针等常见内存错误，对于处理大量敏感用户数据的后端服务至关重要。同时，Rust在处理高并发请求时表现卓越，其性能经过优化后甚至可以超过C/C++，却无需像C/C++那样谨慎的手动管理内存，大大降低开发过程的复杂度和出错风险。在多线程和并发操作方面，Rust的所有权机制与借用检查其保证了数据安全，
有效避免数据竞争和死锁等问题，是的开发者可以轻松编写并发代码。

Zino框架的出现一定程度上缓解了Rust
Web开发框架上手难度偏高的问题。Zino具有简洁的Api设计，使得开发者能更快速的理解与使用框架的各种功能。其完善的ORM组建让数据库操作变得更加便捷高效。

在Rust社区的各种开源项目中，脚手架工具都是重要的一部分，它的存在能帮助学习者快速搭建出一个完整可用的项目，也能帮助开发者快速建立新的项目以及管理这些项目的配置或是提供调试等更多功能。如Anchor框架的Anchor-cli能帮助开发者快速部署智能合约上链。dioxus框架的dioxus-cli提供前端页面的热重载以为页面的开发与调整提速。]


== 研究意义
#Text[尽管Zino框架在开发中为开发者提供大量便利，但在开发外的项目管理、依赖管理、集成与部署等运维操作中尚有欠缺。通过编写一个便捷的脚手架工具，能帮助开发者快速启动与部署项目，尤其对个人开发者或小型团队非常友好，能够节省很多人力成本。]


== 研究内容与组织结构
本设计集中于上述脚手架工具的设计与实现，开发一个方便操作和功能齐备的脚手架工具。

#Text[第一章：阐述互联网发展下Web开发对高效工具的需求。说明Rust语言及Zino框架的优势与现状。强调开发适配zino-cli工具的意义

第二章：介绍开发所用相关技术。

第三章：分析功能需求。

第四章：在需求分析的基础上，对系统进行设计，确定了系统的所有功能模块并通过顺序图对各个模块的实现流程进行了详细的说明。对系统内部实现接口以及对外接口进行了设计与详细的说明。

第五章：对系统的功能进行的页面上的展示以及使用流程的概要性说明。

第六章：总结本论文，分析其在设计、实现上所存在的不足及改进，提出对应的系统需要拓展的一些功能模块。]


== 本章小结
#Text[在本章确定了本论文研究的内容，分析了在当前环境下，本论文的研究背景及其意义。确定了论文的具体研究架构，对每个章节的内容进行了概要性的介绍。]
#pagebreak()



= 相关技术介绍
== 命令行工具相关技术
=== clap-rs

#Text[clap-rs是Rust语言中一款强大的命令行参数解析库。它能让开发者轻松定义、解析复杂的命令行参数和选项。支持子命令、参数验证、自动生成帮助信息等功能，API简洁易用，有效提升了Rust项目处理终端命令的效率与灵活性。

选取clap-rs做为构建cli工具的原因：]
==== 声明式API设计

#Text[clap-rs的优势在于通过Rust的宏机制实现了声明式的参数定义。只需在结构体上标注`#[derive(Parser)]`即可自动按照结构生成命令行参数解析器。通过在结构体内字段上标注`#[arg()]`并填入short，long等参数定义选项或参数功能或默认值等细节。使用时仅需一条match表达式即可接入实际业务逻辑。使用clap-rs无需了解命令行参数解析的具体细节即可快速搭建命令行程序。]

==== 嵌入式文档


#Text[使用clap-rs构建cli时在每个命令（子命令）和每个参数或选项上都可以通过为其添加文档注释直接用作该命令、参数或选项的帮助信息，使开发者与用户角色融为一体，无需重复编写帮助信息。并使可结合cargo快速自动化的将工具文档导出，便于使用者查看。

综上两点，本项目选用clap-rs构建命令行工具]


== 仓库管理相关技术

=== git2

#Text[该库是libgit2库的Rust绑定，所以需要先介绍libgit2项目。

libgit2是git核心方法的可移植、纯C的实现，作为链接库提供可靠的API。libgit2库不是用于替换git工具或其面向用户的命令，而是提供：SHA转换、格式化和缩短；抽象的ODB后端系统；提交、标记、树和blob解析、编辑和回写；树遍历、索引文件、引用管理；高级仓库管理功能；以及其他更多功能

简而言之它提供了将部分git命令的功能集成进其他程序的条件。故开发者无需在子进程中调用机内的git命令来完成仓库管理操作。更好的提高了程序对错误的控制和处理能力。

而git2是使用Rust对libgit2的二次封装，使开发者能够在Rust程序中集成git功能，并在libgit2的基础上进一步强化安全性。例如使用全自动的资源管理，像所有接口添加强类型约束以便可以利用Rust语言的编译期类型检查来排查错误。]

== 前端技术介绍
=== HTML

#Text[HTML是网页开发的基础语言。它使用各种标签来结构化文本、图像、链接等网页元素，浏览器通过解析这些标签来展示页面内容。HTML具有广泛的兼容性，能在不同设备上呈现网页，
HTML5新增了多媒体支持、本地存储等功能，进一步拓展了网页的应用场景。]

=== CSS


#Text[CSS，即层叠样式表，是网页设计的关键技术，用于控制网页的外观与格式。

它可精准设定文字字体、颜色、大小，调整段落间距、对齐方式，把控图片位置与大小，决定网页整体布局等。通过为
HTML 元素匹配样式规则，实现对网页的美化。

CSS
能极大提升网页视觉效果，在响应式设计中发挥重要作用，确保网页在不同设备上都能完美呈现。同时，它将样式与内容分离，方便维护与更新，提高网页开发效率。]

=== JavaScript
#Text[JavaScript是一种轻量级的解释型语言，由Brendan
Eich于1995为浏览器开发，作为Web核心技术之一，为Web前端页面提供灵动性。

#par[]

本设计由于需要把前端嵌入至二进制，为避免引入过多依赖导致二进制膨胀，故选用原生HTML+CSS+JavaScript实现前端。]


== 后端技术介绍
=== Zino框架


#Text[作为Zino框架的脚手架工具，后端服务理应选择Zino框架开发。

Zino致力于打造基于Rust语言的新一代组装式应用开发框架，提供一站式跨平台多端解决方案，可用于后端API开发、桌面应用开发等。我们奉行“约定优于配置”的原则，提供开箱即用的功能模块，极大提升开发效率；并通过应用接口抽象与actix-web、axum、dioxus、ntex等框架集成，打通社区生态。]


== 其他相关技术介绍
=== tokio-rs

#Text[Rust对高效异步编程的支持是其一大特色，但Rust本身并没有规定异步运行时（或成为异步任务调度器）的具体实现。Tokio是社区中最常用的异步运行时，基于Rust的async/await语法构建，将用户代码转化为状态机进行调度，但开发者完全无需了解背后的多线程和状态机的具体实现细节，就可以轻松编写安全而高效的并发程序，提高程序效率与硬件资源利用率，降低开发、运维和硬件成本。]


== 本章小结

#Text[本章对项目所使用到的技术进行一个大致的介绍，选用git2作为管理技术，原生H5工具链进行前段搭建，Zino框架作为后端开发工具，tokio-rs实现部署时的HTTPS流解包与转发。]
#pagebreak()


= 需求分析

#Text[对软件项目而言，需求分析是项目的开始，这一环节划定了软件工程项

目的范围，对后续的系统设计环节及编码实现环节至关重要。一份内容完备、逻辑清晰的需求分析是后续开发环节能够顺利进行的重要保障。]



== 从模板创建项目
#Text()[
一个脚手架工具最基本的功能是要基于模版创建Zino框架的新项目。类似Rust自带的项目管理工具Cargo一样使用new等用户熟悉的子命令，并需要可以指定项目名称。同时，应该提前准备好一个模板项目，其中包含Zino框架的基础配置，基本的文件和目录结构等。但用户可能有根据自己的习惯常用的项目结构与配置内容，故还需要提供接口以便用户使用指定自己制作的模板创建项目。
]


== 使用模板原地初始化项目


#Text[在实际开发场景中，存在这样一种常见需求：用户在已有的其他前端项目或复杂项目群中，期望嵌入
Zino 框架的新项目。例如，某团队正在进行一个大型 Web
应用的迭代开发，该应用包含多个不同技术栈的模块，现在需要在其中一个特定模块中引入
Zino
框架来实现新功能。此时，用户便希望能够将当前所在目录快速初始化为一个
Zino
项目。默认情况下应该使用当前目录名作为项目名，但也需要提供接口供用户指定其他名称。同上也需要提供接口指定用户选择其他的模板。]

== 启动本地HTTP服务，提供可视化依赖管理
#Text[Zino框架配置项较多且较为复杂。从其项目主页中可以找到，如@fig:zino-features @fig:core-features 所示。 #figure(image("media/zino-features.png"),caption: [Zino配置选项])<zino-features>#figure(image("media/core-features.png"),caption: [Zino-Core配置选项（不完全）])<core-features>所以提供一个可视化的配置管理机制是很有必要的。但Zino-cli作为一个命令行工具，难以提供复杂的界面交互。故需要通过在本地启动一个HTTP服务，通过浏览器提供的页面渲染与交互功能实现复杂的界面功能。]

=== 前端页面
#Text[在可视化配置管理机制的前端页面设计中，首要功能是提供一个输入框，方便用户指定需要管理的项目路径。通过此输入框，用户能够随时更改到目标项目路径而无需进入目标项目后重新启动程序。页面中还需完整展示现有项目的配置文件，以直观的形式呈现给用户，让用户对项目当前的配置状况一目了然。​

配置设置方面，页面提供一个选项区域，列出所有的配置选项。该区域用于用户对配置进行选择操作。用户可在这一区域针对各项配置参数进行个性化调整，涵盖框架核心参数、插件启用设置等各类关键配置项。另外，为了让用户在确认修改前充分了解配置变更后的效果，页面还应具备更新后的配置文件预览功能。用户在选项区域做出选择后，预览区域能够实时展示修改后的配置文件内容，便于用户进行核对与确认。]


=== 后端接口
#Text[对应前端的功能，后端需要提供接口返回当前正在配置的项目路径，并可以根据前端的提交信息更新配置的项目路径。项目启动时默认应该使用当前路径作为配置的目标项目。前端页面中展示当前项目的配置详情功能需要后端整理当前的配置文件并从中解析出已开启的配置选项，然后将其返回给前端。用户在前端中开启或关闭配置项后，后端应该根据配置项的更新生成一份新的配置文件内容，但不即时保存，仅作为预览提供给前端。前端在确认需要保存配置文件的修改后后端再将其保存并将旧的配置文件覆盖。]

== 自动集成与自动部署功能

#Text[
在传统的开发工作流程中，开发者需要在开发环境完成开发后，手动将代码上传至生产环境，并重新启动项目完成替换。如有依赖项更新或软件环境或配置的更新，同样需要在生产环境中手动下载安装这些更新，这不仅加大了开发人员的工作量，还引入非常多不确定性，可能导致各种兼容性问题，拖慢项目进度。如@fig:old-workflow 所示。
#figure(image("media/传统开发.png",height: 200pt), caption:[传统开发流程],kind: image)<old-workflow>
所以Zino-cli需要提供一个模块帮助开发者自动将开发环境的代码集成到生产环境中，并自动完成重新部署的流程。为了保证生产环境中的应用持续可用，在集成过程中应该同时自动完成编译检查与测试，若不通过则应该取消更新。避免更新错误的代码导致生产环境项目和数据损毁的情况。开发者在使用过程中，仅需在第一次部署时登陆远程服务器，开启自动集成部署功能。后续开发过程中仅需将代码提交至远程仓库，其余部署工作zino-cli将代为处理。如@fig:new-workflow 所示。 
#figure(image("media/自动部署.png",height: 180pt), caption:[新开发流程],kind: image)<new-workflow>
]


== 自动配置HTTPS证书功能
#Text[在Web开 发中，配置HTTPS证书一直是一项繁琐的工作，并且一次配置证书是不够的，HTTPS证书是有有效期的，还需要定期项证书颁发机构申请重新续签证书。在很多中小型团队并没有专门的运维岗位，大部分运维工作都由开发人员兼职完成，繁琐的证书配置与管理流程极大的加重了这部分开发人员的运维压力。其次，国内如阿里云等云服务厂商提供的HTTPS证书申请服务收费及其高昂，价格动辄达到数千元/年，对中小型团队以及个人开发者来说是一笔非常大的经济负担。如@Alipay 所示#figure(image("media/阿里云收费.png"),caption: [阿里云配置证书收费页面],kind:image)<Alipay> 
但是事实上市场上早有公益的证书颁发机构，开发者可以向这些机构申请免费证书。各大云服务厂商却为了售卖自己的服务不提供此类机构的证书申请渠道，利用用户对平台的信任，引导用户认为HTTPS证书付费是理所应当的。导致很多不熟悉市场环境的开发者平白承受了高昂的费用。

所以Zino-cli的目标是帮助开发者向此类公益机构申请免费的HTTPS证书，并提供全自动的证书配置与管理功能，以及全自动定期完成续签。一方面为中小团队与个人开发者节约HTTPS证书带来的高昂成本，另一方面解放开发人员的生产力，使开发人员能从运维工作中抽身，专注于项目的功能与业务开发。]

== 本章小结


#show heading: i-figured.reset-counters
#Text[本章介绍了项目的功能，确定了涵盖从模板创建项目、使用模板原地初始化项目、提供可视化配置管理，以及自动集成与自动部署、自动配置HTTPS证书等在内的核心功能。满足了开发者们快速启动项目、快速管理项目配置、全自动的集成部署以及全自动的免费HTTPS证书配置与管理功能。解决了大量开发过程中的痛点，尤其是对于中小团队及个人开发者来说，本项目能大幅降低他们的开发的成本，提高开发效率。]



#pagebreak()
= 系统设计
==  系统架构设计
在该系统中，主要分为3大功能模块，通过clap-rs构建于不同的子命令中。用户通过使用不同的子命令并填入所需参数调用对应模块。如 @fig:总架构图 所示
#figure(
  image("media/总架构.png",
  ),
  caption: [总架构],
  kind: image
) #<总架构图>


== 系统功能设计
=== 安装脚手架工具

#Text[本工具将代码通过GitHub提交Pull
Request的方式交由Zino项目的创始人，其合并代码后将本工具发布到Rust语言官方包仓库crates.io上，用户将可以使用Rust官方的包管理器Cargo安装。]

=== 查看工具版本

#Text[本工具将提供 -v 或 \--version
选项供用户查看版本。同时可用于检查安装是否成功。]

=== 查看工具使用手册

#Text[本工具将提供 -h 或 \--help 选项供用户查看使用手册。]


=== 创建项目

#Text[本工具将提供new命令用于创建新项目，接受一个project-name参数用做项目名称。接受一个\--template-path选项，开启选项后可填入额外参数用于指定模板仓库。若不开启选项则使用预先制作好的默认仓库。如 @fig:创建项目
所示]

#figure(image("media/创建项目.png"),
  caption: [创建项目],kind:image,
)<创建项目>


=== 原地初始化项目


#Text[本工具将提供init命令用于将当前目录按照模版初始化为一个项目，默认使用目录名作为项目名。接受一个\--project-name选项用做项目名称。开启选项后可以填入额外参数用于指定项目名称。接受一个\--template-path选项，开启选项后可填入额外参数用于指定模板仓库。若不开启选项则使用预先制作好的默认仓库。]


=== 配置管理服务设计


#Text[本工具将提供serve命令用以启动配置管理服务，开启后用户可以在浏览器中打开127.0.0.1:6080/zino-config.html访问配置服务

用户访问配置服务页面时，前端在页面元素渲染完成后，向后端发起请求获取当前项目的配置信息，包括项目名称，项目路径与配置文件内容，并将已开启的配置选项情况渲染在页面中。如图
0-3所示。]

图 0-3获取当前配置

#Text[用户可在页面中查看配置详情与配置文件具体内容。在页面中点击配置选项可开启或关闭某项配置。用户修改配置时，前端将向后端发起请求以修改后的配置为基础生成一份新配置文件的预览版。前端收到后端返回的预览内容后将其渲染到页面的对应板块中供用户检查。如@fig:修改配置 所示。]

#figure(image("media/配置管理-修改配置.png"),
  caption: [
    修改配置
  ],kind:image
)<修改配置>

#Text[用户重复上述修改过程直到满意后点击保存配置按钮，前端将最终的配置文件内容提交至后端，后端将新配置文件内容保存至文件系统中。如@fig:保存配置 所示。]

#figure(image("media/保存配置.png"),
  caption: [
    保存配置
  ],kind:image
)<保存配置>

=== 自动集成与部署功能设计


#Text[用户使用deploy命令开始执行自动集成与部署。]

=== 加载配置文件


#Text[从文件系统加载配置文件，文件内包含需要监控的远端仓库信息、指定的分支信息、配置HTTPS证书时使用的域名、邮箱、模式等信息、用户程序端口及代理监听端口等信息。]


=== 配置HTTPS证书



+ 从配置文件中读出域名、邮箱等信息。
+ 监听配置文件中等指定端口。
+ 将启动转发程序。
+ 转发程序将收到的tls流解包。
+ 将解包出的http请求转发给用户程序。
+ 收到用户程序响应后将响应打包进tls流返回给请求者。
+ 向Let's Encrypt发起ACME验证请求。
+ Let's Encrypt会发起HTTPS请求以验证指定域名确实存在服务。
+ 转发程序按上述流程转发处理Let's Encrypt发起的HTTPS请求。
+ 验证通过后将收到的证书信息及缓存信息保存至配置文件中指定的缓存目录。



=== 部署流程

+ 运行用户程序。

+ 检查远端仓库指定分支最新提交哈希是否与本地分支最新提交哈希一致。

+ 若一致则说明远端无更新。

+ 无更新则结束检查并等待配置文件中指定的轮询间隔

+ 若远端最新提交哈希值与本地不一致则说明远端仓库有更新。

+ 有更新则拉取新代码，运行编译检查和测试。

+ 若检查和测试成功则杀灭旧用户程序进程，以版本代码开启进程，实现替换。


#pagebreak()
==  系统接口设计
===  用户接口
==== 安装工具

用户可使用Rust官方包管理工具Cargo安装本工具。见@tbl:安装工具 。

#figure(
  align(center)[#table(
    columns: (21.41%, 16.1%, 16.1%, 23.24%, 23.16%),
    align: (auto,auto,auto,auto,auto,),
    table.header([接口名称], [交互方式], [前驱事件], [响应事件], [参数],),
    table.hline(),
    [安装工具], [终端命令], [用户打开终端并已安装Rust工具链], [Cargo将自动从Rust官方包仓库下载并编译安装本工具], [通过向Cargo指定\--version参数可选择需要安装的具体版本],
  )], caption: [用户安装本工具], kind: table
)<安装工具>


=== 检查工具版本


在用户安装工具后可通过调用-v或\--version选项查看工具版本。见@tbl:查看版本。

#figure(
  align(center)[#table(
    columns: (21.41%, 16.1%, 16.1%, 23.24%, 23.16%),
    align: (auto,auto,auto,auto,auto,),
    table.header([接口名称], [交互方式], [前驱事件], [响应事件], [参数],),
    table.hline(),
    [查看工具版本], [终端命令], [用户安装工具], [工具将在终端中输出版本信息], [无],
  )]
  , caption: [查看工具版本接口

  ]
  , kind: table
  )<查看版本>


=== 查看使用手册
在用户安装工具后通过调用-h或\--help选项查看使用手册。见@tbl:-h。

#figure(
  align(center)[#table(
    columns: (21.41%, 16.1%, 16.1%, 23.24%, 23.16%),
    align: (auto,auto,auto,auto,auto,),
    table.header([接口名称], [交互方式], [前驱事件], [响应事件], [参数],),
    table.hline(),
    [查看使用手册], [终端命令], [用户安装工具], [工具在终端中输出使用手册], [无],
  )]
  , caption: [表 4.3 查看使用手册接口

  ]
  , kind: table
  )<-h>


=== 创建新项目

在用户安装工具后，通过调用new子命令并填入project-name参数创建名为project-name的新项目。通过可选的\--template选项并填入模板链接可指定创建项目所用模板。见@tbl:new。

#figure(
  align(center)[#table(
    columns: (15.11%, 9.96%, 16.98%, 19.8%, 16.4%, 21.74%),
    align: (auto,auto,auto,auto,auto,auto,),
    table.header([接口名称], [交互方式], [前驱事件], [响应事件], [参数], [可选选项与参数及含义],),
    table.hline(),
    [创建项目], [终端命令], [用户安装工具], [工具将拉取仓库代码并将其处理为新项目], [项目名称], [\--template
    \<template-url\>
    指定创建项目所用模板仓库
    ],
  )]
  , caption: [新建项目接口]
  , kind: table
  )<new>


=== 就地初始化项目


在用户安装工具后，通过调用init子命令将当前目录初始化为名为当前目录名称的新项目。通过可选的\--template选项并填入模板链接可指定创建项目所用模板。通过可选的\--project-name选项并填入项目名称参数可以换用其他符合Rust语言规范的项目名称。见@tbl:init。

#figure(
  align(center)[#table(
    columns: (15%, 15%, 15%, 21.79%, 8.69%, 26.72%),
    align: (auto,auto,auto,auto,auto,auto,),
    table.header([接口名称], [交互方式], [前驱事件], [响应事件], [参数], [可选选项与参数及含义],),
    table.hline(),
    [就地初始化项目], [终端命令], [用户安装工具], [工具将拉取仓库代码并将其处理为新项目], [无], [\--template
    \<template-url\>
    指定创建项目所用模板仓库
    \--project-name \<project-name\>
    指定其符合Rust语言规范的项目名称

    ],
  )], caption: [就地初始化项目], kind: table
  )<init>

=== 开启配置服务接口
在用户安装工具后，可通过调用工具的serve子命令开启配置服务。见@tbl:serve。

#figure(
  align(center)[#table(
    columns: (21.4%, 16.1%, 16.1%, 23.25%, 23.16%),
    align: (auto,auto,auto,auto,auto,),
    table.header([接口名称], [交互方式], [前驱事件], [响应事件], [参数],),
    table.hline(),
    [开启配置服务], [终端命令], [用户安装工具], [工具在本地启动内置的基于Web的配置调整服务程序], [无],
  )]
  , caption: [开启配置服务接口

  ]
  , kind: table
  )<serve>


=== 配置管理接口

用户安装工具并启动配置管理服务后，可打开浏览器并访问http:\/\/127.0.0.1:6080/zino-config.html即可使用配置管理服务。在页面中可以选择需要管理配置的项目，调整并实时预览项目配置文件，完成后保存配置文件。具体见@tbl:config。

#figure(
  align(center)[#table(
    columns: (21.4%, 16.1%, 16.1%, 23.25%, 23.16%),
    align: (auto,auto,auto,auto,auto,),
    table.header([接口名称], [交互方式], [前驱事件], [响应事件], [参数],),
    table.hline(),
    [打开页面], [在浏览器地址栏中输入服务所在端口及页面], [在终端中启动配置服务], [配置管理页面], [无],
    [选择需要管理配置的项目], [在页面顶部的输入框中输入项目路径，默认使用服务启动时的路径], [在终端中启动配置服务], [渲染选中项目中已有的配置文件，在页面的选框中同步项目中的配置状态。], [项目路径],
    [选择需要开启或者关闭的配置], [鼠标点击页面中的选框], [已加载需要管理配置的项目配置文件], [向后端同步用户选项，收到响应后渲染修改后的配置文件的内容预览], [配置选项],
    [调整最终配置文件内容], [键盘输入], [已加载配置文件], [同步修改内容], [配置文件内容],
    [保存修改], [鼠标点击保存按钮], [已修改配置文件], [同步修改后的项目状态], [无],
  )]
  , caption: [配置管理页面接口

  ]
  , kind: table
  )<config>


=== 自动集成部署接口


用户安装工具后可使用deploy命令启动自动集成与部署，同时完成自动HTTPS证书配置。

deploy命令需要用户编写配置文件以完成功能，配置文件内可包含字段如@tbl:fields

#figure(
  align(center)[#table(
    columns: (30.71%, 27.24%, 22.68%, 19.37%),
    align: (auto,auto,auto,auto,),
    table.header([字段名], [类型], [含义], [默认值],),
    table.hline(),
    [zli-config.fresh-interval], [std::time::Druation], [每次读取新配置文件的间隔时间], [60秒],
    [remote.name], [String], [远端仓库名称], [origin],
    [remote.branch], [String], [远端仓库分支], [main],
    [acme.domain], [Vec\<String\>], [需要配置HTTPS证书的域名], [空列表],
    [acme.email], [Vec\<String\>], [接受证书相关信息的邮箱联系地址], [空列表],
    [acme.product-mode], [bool], [是否开启生产模式（仅在生产模式下可获取Let;s
    Encrypt颁发的证书，非生产模式仅供测试使用）], [false],
    [acme.cache], [PathBuf], [证书缓存信息保存路径], [default/cache/path],
    [acme.listening-at], [u16], [转发程序监听端口（服务器处理HTTPS请求的端口）], [443（HTTPS协议默认请求端口）],
    [acme.forward-to], [u16], [转发目标端口（即用户程序所在端口）], [6080（zino框架程序默认使用端口）],
  )],caption: [配置文件字段]
  , kind: table
  )<fields>

开启持续集成部署功能后zli将持续监听远程仓库变更并跟进更新内容，用户只需将开发环境中的代码推送至远程仓库，而无需手动维护服务器状态。更新过程甚至无需登陆远程服务器，大大减轻运维工作负担。

== 内部接口
=== git项目管理相关接口

此部分接口用于基于git克隆模板并改造处理为新项目，其主要接口见@tbl:git。详细情况请看源码。

#figure(
  align(center)[#table(
    columns: (41.06%, 25.76%, 20.8%, 14.38%),
    align: (auto,auto,auto,auto,),
    table.header([接口名称], [接口说明], [参数], [返回值],),
    table.hline(),
    [get\_git\_proxy], [根据目标仓库地址获取本机代理配置], [仓库地址], [本机代理信息],
    [clone\_template], [克隆模板仓库代码], [目标仓库地址，本机代理信息], [克隆操作状态信息],
    [process\_template], [将拉取到的模板仓库代码改造成新项目], [新项目创建路径，项目名称], [改造操作状态信息],
    [clone\_and\_process\_template], [创建项目逻辑的统一入口，由新建和初始化模块共用], [模板路径，项目路径，项目名称], [创建项目操作状态],
    [is\_ignored], [判断是否需要忽略], [模板仓库中的目录或文件名], [是否需要忽略],
    [clean\_template\_dir], [清理临时模板文件夹], [临时模板文件夹路径], [无],
    [check\_name\_validation], [检查项目名是否符合Rust语言项目名规范], [项目名称], [检查通过与否],
  )]
  , caption: [git项目管理接口
  ]
  , kind: table
  )<git>


=== 新建项目相关接口

新建项目相关接口情况见@tbl:new-project。其详细情况请看系统源码。

#figure(
  align(center)[#table(
    columns: (38.67%, 20.37%, 15.77%, 34.19%),
    align: (auto,auto,auto,auto,),
    table.header([接口名称], [接口说明], [参数], [返回值],),
    table.hline(),
    [check\_project\_dir\_status], [检查项目目录是否已存在且非空], [项目目录], [bool或来自文件系统的Error],
    [new\_with\_template], [调用上述git接口创建项目], [终端命令参数], [成功则无返回值失败则返回创建过程中的错误],
    [run], [子命令总入口], [终端命令参数], [成功则无返回值，失败则返回命令执行过程中的错误（应来自文件系统或网络）],
  )]
  , caption: [新建项目相关接口

  ]
  , kind: table
  )<new-project>


=== 初始化项目相关接口

初始化项目相关接口情况见@tbl:init-project。其详细情况请看系统源码。

#figure(
  align(center)[#table(
    columns: (38.98%, 25%, 16%, 25%),
    align: (auto,auto,auto,auto,),
    table.header([接口名称], [接口说明], [参数], [返回值],),
    table.hline(),
    [init\_with\_template], [调用上述接口创建项目], [终端命令参数], [成功则无返回值，失败则返回过程中出现的错误],
    [run], [子命令总入口], [终端命令参数], [成功则无返回值，失败则返回过程中出现的错误],
    [already\_in\_rust\_project], [检查当前路径是否已是Rust项目], [当前目录], [若是则抛出异常],
  )]
  , caption: [表 4.10 初始化项目相关接口

  ]
  , kind: table
  )<init-project>

#pagebreak()
=== 配置管理服务后端接口
配置管理服务后端接口情况见@tbl:back-end。其详细情况请看系统源码。
#figure(
  align(center)[#table(
    columns: (38.52%, 28.71%, 15.54%, 33.23%),
    align: (auto,auto,auto,auto,),
    table.header([接口名称], [接口说明], [参数], [返回值],),
    table.hline(),
    [run], [启动配置服务], [无], [启动服务后持续监听本机6080端口，直到用户进入终端手动退出程序],
    [/:file\_name], [返回内嵌在二进制中的前端页面、样式及脚本等文件], [file\_name], [内嵌模拟的文件系统中对应名称的文件，若找不到则返回404页面],
    [/current\_dir], [获取当前目录], [无], [当前目录],
    [/update\_current\_dir], [更新需要修改配置的项目所在目录], [path], [若成功则为更新后的目录，否则为变更前的目录],
    [/get\_current\_cargo\_toml], [获取当前目录中的配置文件内容], [无], [若当前目录为Rust项目目录则返回配置文件内容，否则返回错误信息],
    [/generate\_cargo\_toml], [生成修改后的配置文件内容的预览], [配置选项], [若生成成功则返回预览内容，否则返回错误信息],
    [/save\_cargo\_toml], [保存配置文件修改], [修改后的配置文件内容], [若成功返回成功，否则返回错误信息],
    [/get\_current\_features], [获取当前项目已开启的配置情况], [无], [若在Rust项目中则返回当前目录的配置文件中的配置情况，否则返回错误信息],
  )]
  , caption: [后端接口

  ]
  , kind: table
  )<back-end>

  
=== 自动集成部署相关接口
自动集成部署相关接口情况见@tbl:deploy。其详细情况请看系统源码。
#figure(
  align(center)[#table(
    columns: (36.09%, 24.89%, 17.51%, 31.51%),
    align: (auto,auto,auto,auto,),
    table.header([接口名称], [接口说明], [参数], [返回值],),
    table.hline(),
    [run], [子命令总入口], [无], [启动监控长循环，故无返回值],
    [RepositoryManager::\ flush\_zino\_toml], [重新加载配置文件], [无], [无],
    [RepositoryManager::\ try\_update\_\ and\_run\_project], [尝试从远端更新项目代码并运行新代码以替换旧版本], [无], [若成功则无返回值，失败则返回失败信息],
    [RepositoryManager::\ kill\_active\_project], [杀灭旧用户程序进程], [无], [无],
    [RepositoryManager::\ open\_local\_repo], [打开本地git仓库], [无], [成功则返回本地仓库信息，否则返回错误信息],
    [RepositoryManager::\ pull\_remote], [拉取远端仓库更新], [无], [成功则无返回值，失败返回错误信息],
    [RepositoryManager::\ rollback\_to\_\ latest\_checked\_commit], [回滚至上一个通过编译检查和测试的提交], [上一个经过检查的提交的哈希值], [成功则无返回值，失败则返回错误信息],
    [RepositoryManager::\ find\_remot], [获取远端仓库信息], [远端仓库名], [成功则返回远端仓库信息，失败则返回错误信息],
    [RepositoryMnanger::\ run\_project], [运行用户程序], [无], [成功则无返回值，失败则返回错误信息],
    [RepositoryManager::\ check\_and\_test], [运行编译检测和测试], [无], [成功则无返回值，失败则返回错误信息],
    [AcmeManager::\ handle\_tls\_connection], [解包tls流并转发到用户程序], [收到的tls流], [成功则无返回值，失败则返回错误信息],
    [AcmeManager::\ do\_acme\_work\_and\_\ froward\_and\_connections], [发起Acme请求并启动转发程序], [配置文件信息], [长循环，等待用户主动退出],
  )]
  , caption: [表 4.12 部署模块内部接口

  ]
  , kind: table
  )<deploy>


#pagebreak()
== 本章小结
在该章节中对系统各项功能的具体设计进行了介绍。包括架构设计，接口设计，具体流程等。
#pagebreak()


#show heading: i-figured.reset-counters
= 系统实现效果
== 安装脚手架工具
使用 cargo install zino-cli \-\-version 0.4.0即可安装本脚手架工具。如@fig:exmp-install 所示。
#figure(image("media/image8.png"),caption: [安装工具],kind: image)<exmp-install>

运行命令后cargo将开始下载依赖并进行编译安装。如@fig:exmp-install-process 所示。
#figure(box(image("media/image9.png",)),caption: [安装过程],kind: image)<exmp-install-process>

安装完成后显示本工具可以调用，名为zli。如@fig:exmp-install-finish 所示。
#figure(box(image("media/image10.png")),caption: [安装完成],kind: image)<exmp-install-finish>


== 创建新项目
new zino-project 命令即可创建名为zino-project的新项目。如@fig:exmp-new 所示。
#figure(box(image("media/image11.png",)),caption: [使用new命令创建项目],kind:image)<exmp-new>
若有配置git全局代理则将使用代理拉取项目模板以防止网络阻塞导致创建失败。


通过开启可选的\--template参数并填入模板地址可选择任意模板仓库。如@fig:exmp-new-with-template 所示。
#figure(box(image("media/image12.png", height: 2.95972in, width: 5.50625in)),caption: [指定模板地址],kind:image)<exmp-new-with-template>


将当前目录初始化为新项目
使用zli init 命令即可将当前目录初始化为与目录名同名的新项目。如@fig:exmp-init 所示。
#figure((image("media/image13.png")),caption: [使用init命令创建项目],kind: image)<exmp-init>

通过\--project-name参数可以指定其他符合Rust语言规范的项目名称。如@fig:exmp-init-with-name 所示。
#figure(box(image("media/image14.png",)),caption: [指定项目名称],kind: image)<exmp-init-with-name>
通过\--template可以选择任意模板仓库。如@fig:exmp-init-with-template 所示。
#figure(box(image("media/image15.png",)),caption: [指定模板地址],kind: image)<exmp-init-with-template>

以上两个选项可以同时开启。


== 配置管理
在终端使用zli serve命令即可开启配置管理服务。如@fig:exmp-serve 所示。
#figure(box(image("media/image16.png",)),caption: [开启配置管理服务],kind: image)<exmp-serve>

#pagebreak()
然后打开浏览器访问127.0.0.1:6080/zino-config.html即可访问配置管理服务页面并使用。如@fig:exmp-config-page 所示。
#figure(box(image("media/image17.png",)),caption: [配置管理页面],kind: image)<exmp-config-page>


在页面顶部有一个输入框，输入需要管理配置的项目所在的路径即可跳转至对应项目并进行管理。配置管理服务默认打开启动服务的路径。

下方左侧是打开的项目当前的配置文件内容，中部在初始状态下是根据此配置文件内容解析出的依赖选项是否开启的情况，用户可在此处点击需要开启的配置或需要关闭的配置。页面右侧是经修改后的配置选项生成的新配置文件的预览。部分选项属于二级配置，例如：在zino
config中开启orm选项，则core
config中将显示Database栏用以选择需要连接的数据库。如@fig:exmp-config-database 所示。
#figure(box(image("media/image18.png",)),caption: [配置项联动],kind: image)<exmp-config-database>

其中部分选择栏如zino config中的Framework栏、core
config板块中的Database栏为单选（也可不选），其余为可多选栏。

右侧的预览框中可以对zino框架外的其他配置项进行手动编辑调整。如@fig:exmp-config-preview 所示。
#figure(box(image("media/image19.png",)),caption: [配置项预览],kind: image)<exmp-config-preview>

滚动至页面底部有一个保存配置按钮。点击即可将右侧预览框内经过修改的配置文件内容保存至项目。如@fig:exmp-config-save 所示。
#figure(box(image("media/image20.png",)),caption: [保存配置],kind: image)<exmp-config-save>


#pagebreak()
== 自动部署并配置HTTPS证书
编写好项目后在项目跟目录下添加配置文件，格式为Toml文件格式。#linebreak()
内容示例如@fig:exmp-zino-config 所示。
#figure(box(image("media/image21.png",)),caption: [配置文件],kind: image)<exmp-zino-config>

表示以下配置：

#block[
#set enum(numbering: "1.", start: 1)
+ 每10小时检查远端仓库是否更新。

+ 检查更新的目标为origin仓库下的main分支。

+ 需要配置HTTPS证书的域名为列表中的两项。

+ 联系人邮箱------若过期续签出错则联系该邮箱（可填多个）。

+ 证书存放地址。

+ 开启生产模式。

+ tls转发程序监听端口为443。

+ 转发目标端口为6080。
]

#pagebreak()
此时在项目根目录下运行zli deploy即可开启项目。如@fig:exmp-deploy 所示。
#figure(box(image("media/image22.png",)),caption: [自动部署],kind: image)<exmp-deploy>


可以看到自动部署程序唤起了用户基于Rocket构建的Web
API服务。然后程序向Let's Encrypt发起验证请求。机构验证完成后将发送证书信息至服务器，程序收到证书信息后保存至配置文件中指定的路径。

由于该自动部署模块并不要求服务必须构建于Zino框架，故在本例中使用了一个基于Rocket框架构建的服务以说明本模块的泛用性。该服务模拟了一个简单的文件系统，如@fig:exmp-deploy-fs 所示。
#figure(box(image("media/image23.png",)),caption: [模拟文件系统],kind: image)<exmp-deploy-fs>


在浏览器中通过HTTPS协议访问已配置好证书的www.qiumiaomiao.tech域名可以看到正常的Hello，World！内容输出。如@fig:exmp-deploy-hello-world 所示。
#figure(box(image("media/image24.png",)),caption: [Hello，World！],kind: image)<exmp-deploy-hello-world>

访问该域名下的/src/main.rs即可获得模拟文件系统返回的文件内容，即上述Web
API服务的主程序源码文本，如@fig:exmp-deploy-src-main-rs 所示。
#figure(box(image("media/image25.png",)),caption: [Web API服务源码],kind: image)<exmp-deploy-src-main-rs>

将仓库clone到本地作为开发环境。如@fig:exmp-deploy-clone 所示。
#figure(box(image("media/image26.png",)),caption: [clone仓库],kind: image)<exmp-deploy-clone>
在本地修改src/main.rs文件的内容。如@fig:exmp-deploy-modify @fig:exmp-deploy-modify2 所示。
#figure(box(image("media/image27.png",)),caption: [修改文件],kind: image)<exmp-deploy-modify>
#figure(box(image("media/image28.png",)),caption: [修改文件],kind: image)<exmp-deploy-modify2>
#pagebreak()

将修改后的文件提交至本地仓库。如@fig:exmp-deploy-commit 所示。
#figure(box(image("media/image29.png",)),caption: [提交修改],kind: image)<exmp-deploy-commit>

然后通过git将更改提交并推送至远端仓库。如@fig:exmp-deploy-push 所示。
#figure(box(image("media/image30.png",)),caption: [推送修改],kind: image)<exmp-deploy-push>
在远端仓库中可见本次提交。如@fig:exmp-deploy-github 所示。
#figure(box(image("media/image31.png",)),caption: [远端仓库],kind: image)<exmp-deploy-github>
在服务器终端中可以看到自动部署程序检测到远端仓库有更新，并开始拉取更新。如@fig:exmp-deploy-server 所示。
#figure(box(image("media/image32.png",)),caption: [自动部署],kind: image)<exmp-deploy-server>


在浏览器中重新访问修改的文件后也可以确认本次修改。如@fig:exmp-deploy-modify-main 所示。
#figure(box(image("media/image33.png",)),caption: [修改后的文件],kind: image)<exmp-deploy-modify-main>

综上，本工具的自动集成与部署功能实现了一次启动，持续集成的需求。开发者仅需登陆服务器启动部署，之后便无需再次登陆，后续开发过程中仅需将开发环境中的代码推送至远端仓库的指定仓库，便可实现项目的更新。并无需手动配置与管理HTTPS证书，自动部署程序会同时自动管理获取证书及到期自动续签的流程（证书到期时间为90天，一般在到期前30天启动续签，当前无法测试）。


== 本章小结
本章以截图的形式展示了工具的使用方式及响应反馈。


#pagebreak()
= 总结与展望


在本设计中，通过对zino-cli脚手架工具详细的需求分析，系统架构设计、系统功能设计、系统接口设计，最后通过编码实现了一个简洁便利的脚手架工具。在这个过程中，阅读大量的相关文献资料，研究了社区中各个项目的脚手架工具的设计，并且与Zino框架的创始人进行深入的沟通，最终确定了工具的设计。在系统实现过程中，通过查看官方的开发文档以及相关的开发技术书籍，了解到了系统开发的技术难点、要点。

在系统的设计与实现的过程中，了解到需求分析对软件开发的重要性，使我对软件开发的流程有了更深的理解，同时也增强了自己分析和解决问题的能力。

当前的自动部署功能与HTTPS证书自动配置功能绑定，但由于自动集成部署功能使用限制少，完全可以用于非Web
API服务类型的项目，这些项目无需HTTPS证书的配置。Rust具有优秀的条件编译机制，后续可以考虑将HTTPS证书自动配置功能拆分出来，使用特定的编译条件开启。

#pagebreak()
参考文献

#pagebreak()
致 谢

在编写论文的过程中，首先感谢我的指导老师胡东萍，胡冬萍老师在我论文的撰写过程中对我遇到的困难与疑惑进行悉心的指导，提出了很多修改建议与意见，对论文严格把关，为论文的完善倾注了大量的心血，正是由于她的悉心指导，使我能够顺利的完成我的毕业论文。

感谢Zino框架的创始人潘瓒老师耐心与我沟通项目设计需求，确定项目实现方案，并对部分繁冗代码提出优化建议。

感谢Rust社区的各大开源项目。在项目开发过程中，使用到了大量的开源社区提供的工具，并遇到了不少疑惑与Bug。开源社区的开发者对我的疑惑进行及时的解答，对我反馈的问题进行快速的修复，使我能顺利的完成工具的实现。
