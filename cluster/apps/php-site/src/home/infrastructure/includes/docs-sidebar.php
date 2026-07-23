<?php
$current = basename($_SERVER['PHP_SELF']);

$sections = [
    [
        'title' => 'Infrastructure overview',
'items' => [
    ['Overview', '#overview'],
['Terraform', '#terraform'],
['Ansible', '#ansible'],
['GitOps pipeline', '#gitops'],
['Kubernetes', '#kubernetes'],
['Networking', '#networking']
]
    ]
];
?>

<nav class="sidebar-nav" id="sidebarNav" aria-label="Documentation navigation">

<?php foreach ($sections as $section): ?>

<div class="sidebar-title">
<?= htmlspecialchars($section['title']) ?>
</div>

<?php foreach ($section['items'] as $item): ?>

<a
class="sidebar-link"
href="<?= htmlspecialchars($item[1]) ?>">
<?= htmlspecialchars($item[0]) ?>
</a>

<?php endforeach; ?>

<?php endforeach; ?>

</nav>

<div
class="sidebar-backdrop"
id="sidebarBackdrop"
onclick="toggleSidebar()">
</div>

<button
class="sidebar-toggle-btn"
id="sidebarToggleBtn"
onclick="toggleSidebar()"
aria-label="Open documentation menu">

☰ Sections

</button>
<script>
window.addEventListener('resize', () => {

    if(window.innerWidth > 768){

        document
            .getElementById('sidebarNav')
            .classList.remove('open');

        document
            .getElementById('sidebarBackdrop')
            .classList.remove('open');

    }

});
</script>