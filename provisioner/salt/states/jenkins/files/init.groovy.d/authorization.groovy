import jenkins.model.*
import hudson.security.*
import hudson.plugins.*
import hudson.plugins.active_directory.*
import hudson.*
import jenkins.*

//def jenkinsInstance = Jenkins.getInstance()
//
//String domain = 'ad.mycompany.com'
//String site = 'site'
//String adServerIps = ''
//String bindName = 'jenkins@ad.mycompany.com'
//String bindPassword = 'asdasd'
//
//adrealm = new ActiveDirectorySecurityRealm(domain, site, bindName, bindPassword, adServerIps)
//jenkinsInstance.setSecurityRealm(adrealm)