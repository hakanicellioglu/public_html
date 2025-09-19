  </main>
  <footer class="container py-4 text-center small text-muted d-print-none">
    &copy; <?= date('Y'); ?> TeklifPro
  </footer>

  <div id="toastContainer" class="toast-container position-fixed bottom-0 end-0 p-3 d-print-none"></div>

  <div class="modal fade d-print-none" id="confirmModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Onayla</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Kapat"></button>
        </div>
        <div class="modal-body"></div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">İptal</button>
          <button type="button" id="confirmYes" class="btn btn-danger">Evet</button>
        </div>
      </div>
    </div>
  </div>

<script src="assets/app.js" defer></script>
<script src="public/js/product_form.js" defer></script>
<script src="public/js/customer.js" defer></script>

</body>
</html>
