(window.webpackJsonp=window.webpackJsonp||[]).push([[94],{"8li0":function(module,e,n){"use strict";n.d(e,"b",(function(){return m}));var t=n("vaU+"),r=n("/WoZ"),a=n("tEn/"),s={isLaunched:function isLaunched(e){return!!e.launchedAt&&e.launchedAt<=Date.now()},isPreEnrollmentEnabled:function isPreEnrollmentEnabled(e){return!this.isLaunched(e)&&"preEnrollmentEnabledAt"in e},isSessionsModeEnabled:function isSessionsModeEnabled(e){return void 0!==e.sessionsEnabledAt&&e.sessionsEnabledAt<=Date.now()},isVerificationEnabled:function isVerificationEnabled(e){return!!e.verificationEnabledAt&&e.verificationEnabledAt<=Date.now()},isPrivate:function isPrivate(e){return Object(t.g)(e)},isFullC4CPartner:function isFullC4CPartner(e){var n=e.isC4CPartner,t=e.isPrivateAuthoringPartner;return n&&!t},getCourseCatalogType:function getCourseCatalogType(e){var n=r.a.PUBLIC;return s.isPrivate(e)?n=r.a.PRIVATE:e.isLimitedToEnterprise&&(n=r.a.ENTERPRISE),n},isProject:function isProject(e){return[a.a.PROJECT,a.a.RHYME_PROJECT].includes(e)}};e.a=s;var o=s.isLaunched,i=s.isPreEnrollmentEnabled,c=s.isSessionsModeEnabled,u=s.isVerificationEnabled,l=s.isPrivate,d=s.isFullC4CPartner,m=s.getCourseCatalogType,h=s.isProject},"jq+c":function(module,e,n){"use strict";n.r(e);var t=n("VbXa"),r=n.n(t),a=n("q1tI"),s=n("S+eF"),o=n.n(s),i=n("DnuM"),c=n("sQ/U"),u=n("hs7e"),l=n("fw5G"),d=n.n(l),m=n("TKYU"),membershipsData=function(e){var n=(new d.a).addQueryParam("q","findByUser").addQueryParam("userId",e);return o()(m.a.get(n.toString()))},h=n("welz"),p=n.n(h),v=n("pWop"),f,g=p.a.Collection.extend({model:v.a,getEnrolled:function getEnrolled(){return this.filter((function(e){return e.get("courseRole")!==v.a.NOT_ENROLLED}))}}),promises_memberships=function(e){var n=membershipsData(e).then((function(e){return new g(e.elements)}));return n.done(),n},C=n("8li0"),b=Object(i.a)("/api/reports.v1",{type:"rest"}),E="teachVisitedAt",y=10080,w={getBannerData:function getBannerData(){var e=this;return this.getTeachingCourse().spread((function(n,t){return[n,t,e.getLearnerCounts(n,t)]}))},getVisitedTimestamp:function getVisitedTimestamp(){return localStorage.teachVisitedAt},setVisitedTimestamp:function setVisitedTimestamp(){localStorage.teachVisitedAt=Date.now()},shouldShow:function shouldShow(){var e=this.getVisitedTimestamp();if(e){var n=new Date(parseInt(e)),t=new Date(Date.now()),r,a,s;return 60*t.getHours()+t.getMinutes()-(60*n.getHours()+n.getMinutes())>10080}return!0},getTeachingCourse:function getTeachingCourse(){var e=c.a.get().id;if(!e)return o.a.reject();return promises_memberships(e).then((function(e){var n=e.find((function(e){return e.hasTeachingRole()}));if(n&&"UNIVERSITY_ADMIN"!==n.get("courseRole")){var t=n.get("courseId");return[n,u.a.fromId(t)]}return o.a.reject()})).spread((function(e,n){return C.a.isLaunched(n)?[e,n]:o.a.reject()}))},getLearnerCounts:function getLearnerCounts(e,n){var t=this;return o()(b.get("Course~".concat(n.id,"~activity_learner_counts"))).then((function(r){return t.validateLearnerCountsResponse(r)?r.elements[0].body:o.a.reject({membership:e,course:n})}))},validateLearnerCountsResponse:function validateLearnerCountsResponse(e){return e.elements&&e.elements[0]&&e.elements[0].body&&e.elements[0].body.latest&&e.elements[0].body.latest.starter_ever_count&&e.elements[0].body.latest.active_learner_past_1w_count&&e.elements[0].body.latest.visitor_ever_count&&e.elements[0].body["1w_ago"]&&e.elements[0].body["1w_ago"].starter_ever_count},getWeeklyNewLearnerCount:function getWeeklyNewLearnerCount(e){return e.latest.starter_ever_count-e["1w_ago"].starter_ever_count},getWeeklyActiveLearnerCount:function getWeeklyActiveLearnerCount(e){return e.latest.active_learner_past_1w_count},getTotalLearnerCount:function getTotalLearnerCount(e){return e.latest.visitor_ever_count}},L=w,T=w.getBannerData,k=w.getVisitedTimestamp,B=w.setVisitedTimestamp,N=w.shouldShow,A=w.getTeachingCourse,P=w.getLearnerCounts,D=w.validateLearnerCountsResponse,R=w.getWeeklyNewLearnerCount,W=w.getWeeklyActiveLearnerCount,V=w.getTotalLearnerCount,j=n("wab5"),S=n("17x9"),I=n.n(S),M=n("kvW3"),q,x=function(e){function TotalLearnerBanner(){return e.apply(this,arguments)||this}var n;return r()(TotalLearnerBanner,e),TotalLearnerBanner.prototype.render=function render(){var e=this.props.course,n=e.name,t="/teach/".concat(e.slug),r=L.getTotalLearnerCount(this.props.learnerCounts);return a.createElement("div",{className:"rc-TotalLearnerBanner"},"A total of"," ",a.createElement("a",{href:t},a.createElement("strong",{className:"c-teach-banner-learner-count"},a.createElement(M.c,{value:r})," learners"))," ","are enrolled in ",a.createElement("span",{className:"c-teach-banner-course-name"},n),". View more on the"," ",a.createElement("a",{href:t},q||(q=a.createElement("strong",null,"Course Dashboard."))))},TotalLearnerBanner}(a.Component);x.propTypes={course:I.a.object.isRequired,learnerCounts:I.a.object.isRequired};var O=x,U,F=function(e){function WeeklyActiveLearnerBanner(){return e.apply(this,arguments)||this}var n;return r()(WeeklyActiveLearnerBanner,e),WeeklyActiveLearnerBanner.prototype.render=function render(){var e=this.props.course,n=e.name,t="/teach/".concat(e.slug),r=L.getWeeklyActiveLearnerCount(this.props.learnerCounts);return a.createElement("div",{className:"rc-WeeklyActiveLearnerBanner"},a.createElement("a",{href:t},a.createElement("strong",{className:"c-teach-banner-learner-count"},a.createElement(M.c,{value:r})," learners"))," ","were active in ",a.createElement("span",{className:"c-teach-banner-course-name"},n)," in the past week. View more on the"," ",a.createElement("a",{href:t},U||(U=a.createElement("strong",null,"Course Dashboard."))))},WeeklyActiveLearnerBanner}(a.Component);F.propTypes={course:I.a.object.isRequired,learnerCounts:I.a.object.isRequired};var J=F,H,Q=function(e){function WeeklyNewLearnerBanner(){return e.apply(this,arguments)||this}var n;return r()(WeeklyNewLearnerBanner,e),WeeklyNewLearnerBanner.prototype.render=function render(){var e=this.props.course,n=e.name,t="/teach/".concat(e.slug),r=L.getWeeklyNewLearnerCount(this.props.learnerCounts);return a.createElement("div",{className:"rc-WeeklyNewLearnerBanner"},a.createElement("a",{href:t},a.createElement("strong",{className:"c-teach-banner-learner-count"},a.createElement(M.c,{value:r})," learners"))," ","enrolled in ",a.createElement("span",{className:"c-teach-banner-course-name"},n)," in the past week. View more on the"," ",a.createElement("a",{href:t},H||(H=a.createElement("strong",null,"Course Dashboard."))))},WeeklyNewLearnerBanner}(a.Component);Q.propTypes={course:I.a.object.isRequired,learnerCounts:I.a.object.isRequired};var Y,z,G,K=[{key:"weeklyActiveLearner",component:J},{key:"weeklyNewLearner",component:Q},{key:"totalLearner",component:O}],X=function(e){function TeachBanner(){for(var n,t=arguments.length,r=new Array(t),a=0;a<t;a++)r[a]=arguments[a];return(n=e.call.apply(e,[this].concat(r))||this).state={course:null,membership:null,learnerCounts:{},bannerIndex:-1,dismissed:!1},n.handleDismiss=function(){L.setVisitedTimestamp(),n.setState({dismissed:!0})},n}r()(TeachBanner,e);var n=TeachBanner.prototype;return n.componentDidMount=function componentDidMount(){var e=this;L.getBannerData().spread((function(n,t,r){var a=Math.round(Math.random()*(K.length-1));e.setState({course:t,membership:n,learnerCounts:r,bannerIndex:a})})).catch((function(){})).done()},n.renderBanner=function renderBanner(){var e=K[this.state.bannerIndex].component;return(a.createElement(e,{course:this.state.course,learnerCounts:this.state.learnerCounts}))},n.render=function render(){if(!this.state.course||this.state.dismissed||!L.shouldShow())return z||(z=a.createElement("div",null));return(a.createElement("div",{className:"rc-TeachBanner bt3-alert bt3-alert-info bt3-alert-dismissable"},a.createElement("div",{className:"c-teach-banner-content"},a.createElement("button",{onClick:this.handleDismiss,className:"bt3-close","data-dismiss":"alert","aria-label":"Close"},G||(G=a.createElement("span",{"aria-hidden":"true"},"×"))),this.renderBanner())))},TeachBanner}(a.Component),Z=e.default=X},wab5:function(module,exports,e){e("xTv4")},xTv4:function(module,exports,e){}}]);
//# sourceMappingURL=94.0358fad83bd0541e7447.js.map